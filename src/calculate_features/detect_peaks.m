function scaled_peaks = detect_peaks(signal, id, debug, fig_handle, signal_type)
    global ecg_settings;
    global ldv_settings;
    global plot_panel;
    global undock_plots;
    %   Clear our variables
    clear high_pass_filtered filtered1 scaled_peaks filtered2 peaks2 fresult
    
    switch signal_type
        case 'ecg'
            apply_trim_filter = ecg_settings.apply_trim_filter;
            samplerate = ecg_settings.targetrate;
            WinSize = ecg_settings.window_size;
        case 'ldv'
            apply_high_pass_filter = ldv_settings.apply_high_pass_filter;
            apply_trim_filter = ldv_settings.apply_trim_filter;
            samplerate = ldv_settings.targetrate;
            WinSize = ldv_settings.window_size;
            peak_detect_alg = ldv_settings.peak_detect_alg;
    end
    
    if debug
        if undock_plots
            figure(fig_handle);
            set(gcf,'NumberTitle', 'off')
            set(gcf, 'Position', get(0,'Screensize'));
        else
            axes('parent', plot_panel);
        end
        
        arrayfun(@cla,findall(0,'type','axes'))
        
        %   Original input ECG data
        subplot(2, 1, 1);
        plot(signal);
        title({['\bf Subject ', num2str(id)]; 'Original Signal'});
        %ylim([-0.2 1.2]);
    end
    
    %If we haven't high pass filtered it yet, filter it now
    if ~apply_high_pass_filter
       trim_filtered = signal;
    else
        fresult=fft(signal);
        trim_filtered = real(ifft(fresult));
        trim_filtered(1:samplerate) = 0;
        trim_filtered(end-samplerate:end) = 0;
%         Code below is for a high pass filter, not trim filter
%         fresult(1 : round(length(fresult)*5/samplerate))=0;
%         fresult(end - round(length(fresult)*5/samplerate) : end)=0;
    end
    
    % Zero first and last second of data
    % beacause fft and ifft process introduce spikes at the ends of the signal
   
    %peak detection split
    if(strcmp(peak_detect_alg, 'Tokotch Method'))
        %fprintf('tokotch method');
        peaks = tokotch_peak_detection(trim_filtered, 50, 650, 700, 50);
       
    else
        %fprintf('obrien method');
        peaks = obrien_peak_detection(trim_filtered, WinSize);
        peaks(find(peaks)) = 1;
    end
    p_peak_locs = find(peaks == 1);
    s_peak_locs = find(peaks == 2);
    %end peak detection split.
    
    %%%%%% REMOVES THE FIRST PEAK
%     for index = 1:1:length(peak_locs)
%         if(peak_locs(index) > 0)
%             peak_locs(index) = [];
%             break;
%         end
%     end
%     %%%%%% REMOVES THE LAST PEAK
%     for index = length(peak_locs):-1:1
%         if(peak_locs(index) > 0)
%             peak_locs(index) = [];
%             break;
%         end
%     end
    
    if debug
        %   Filtered ECG (2-d pass) - now filter has optimized window size
        subplot(2, 1, 2);
        plot(p_peak_locs, trim_filtered(p_peak_locs), 'go');
        hold on;
        plot(s_peak_locs, trim_filtered(s_peak_locs), 'bo');
        hold on;
        plot(1:length(trim_filtered), trim_filtered, 'r');
        
        hold off
        title('\bf R-Peaks Detected - 1^{st} Pass');
        %ylim([0 1.4]);
    end
    
    scaled_peaks = peaks;
    
    drawnow
    
end

% END OF FILE