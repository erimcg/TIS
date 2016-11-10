%   Based on the LIBROW_R_PEAK_DETECT algorithm by Sergey Chernenko 
%   downloaded from http://www.librow.com (S.Chernenko@librow.com)

function scaled_peaks = librow_r_peak_detect(signal, id, debug, fig_handle)

    global ecg_settings;
    
    global plot_panel;
    global undock_plots;
    
    %   Clear our variables
    clear high_pass_filtered filtered1 scaled_peaks filtered2 peaks2 fresult

    apply_high_pass_filter = ecg_settings.apply_high_pass_filter;
    samplerate = ecg_settings.targetrate;

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
                    subplot(5, 1, 1); 
                    plot(signal);
                    title({['\bf Subject ', num2str(id)]; 'Original Signal'});
                    %ylim([-0.2 1.2]);
                end

    % If we haven't high pass filtered it yet, filter it now
    if ~apply_high_pass_filter
        fresult=fft(signal);
        fresult(1 : round(length(fresult)*5/samplerate))=0;
        fresult(end - round(length(fresult)*5/samplerate) : end)=0;
        high_pass_filtered = real(ifft(fresult));
    else
        high_pass_filtered = signal;
    end
    
    % Zero first and last second of data
    % beacause fft and ifft process introduce spikes at the ends of the signal
    high_pass_filtered(1:samplerate) = 0;
    high_pass_filtered(end-samplerate:end) = 0;
   
    %   Filter - first pass
    %WinSize = floor(samplerate * 571 / 1000);
    WinSize = floor(samplerate * 400 / 1000);
    
    if rem(WinSize,2)==0
        WinSize = WinSize+1;
    end
    
    peaks = librow_winmax(high_pass_filtered, WinSize);
    peak_locs = find(peaks);
    
    d = std(high_pass_filtered(peak_locs));
    m = mean(high_pass_filtered(peak_locs));
    high = m + (3*d);
    low = m - (3*d);
    
                if debug
                    %   Filtered ECG (2-d pass) - now filter has optimized window size
                    subplot(5, 1, 2);
                    plot(peak_locs, high_pass_filtered(peak_locs), 'go');
                    hold on
                    plot(1:length(high_pass_filtered), high_pass_filtered, 'r');
%                     yPos = low;
%                     plot(get(gca,'xlim'), [yPos yPos], 'b');
%                     yPos = high;
%                     plot(get(gca,'xlim'), [yPos yPos], 'b');
%                     plot(get(gca,'xlim'), [m, m], 'g');
                    hold off
                    title('\bf R-Peaks Detected - 1^{st} Pass');
                    %ylim([0 1.4]);
                end

%     % Scale signal
%     scaled_peaks = peaks / (max(peaks)/7);
%     
%     %  Filter by threshold filter
%     for i = 1:length(scaled_peaks)
%         if scaled_peaks(i) < 4
%             scaled_peaks(i) = 0;
%         else
%             scaled_peaks(i) = 1;
%         end
%     end

    for i = 1:length(peaks)
        if peaks(i) < m  || peaks(i) > high
            scaled_peaks(i) = 0;
        else
            scaled_peaks(i) = 1;
        end
    end
                
    peak_locs = find(scaled_peaks);
    
                if debug
                    %   Filtered ECG (2-d pass) - now filter has optimized window size
                    subplot(5, 1, 3);
                    plot(peak_locs, high_pass_filtered(peak_locs), 'go');
                    hold on
                    plot(1:length(high_pass_filtered), high_pass_filtered, 'r');
                    yPos = high;
                    plot(get(gca,'xlim'), [yPos yPos], 'b');
                    plot(get(gca,'xlim'), [m m], 'g');                    
                    hold off
                    title('\bf R-Peaks Detected - 1^{st} Pass - Threshold Filtered'); 
                    %ylim([0 1.4]);
                end
  
    positions = find(scaled_peaks);
    
    % Find min distance between peaks
    distance = positions(2) - positions(1);
    
    for i = 1:length(positions)-1
        if positions(i+1) - positions(i) < distance
            distance = positions(i+1) - positions(i);
        end
    end
    
    % Optimize filter window size
    QRdistance = floor(0.04*samplerate);
    
    if rem(QRdistance,2) == 0
        QRdistance = QRdistance + 1;
    end
    
    WinSize = 2 * distance - QRdistance;
    
    % Filter - second pass
    peaks = librow_winmax(high_pass_filtered, WinSize);
    peak_locs = find(peaks);
       
                if debug
                    %   Filtered ECG (2-d pass) - now filter has optimized window size
                    subplot(5, 1, 4);
                    plot(peak_locs, high_pass_filtered(peak_locs), 'go');
                    hold on
                    plot(1:length(high_pass_filtered), high_pass_filtered, 'r');

                    hold off
                    title('\bf R-Peaks Detected - 2^d Pass'); 
                    %ylim([0 1.4]);
                end
                
    d = std(high_pass_filtered(peak_locs));
    m = mean(high_pass_filtered(peak_locs));
    high = m + (3*d);
    low = m - (d);                
    
%     scaled_peaks = peaks / (max(peaks)/7);  
    
    %  Filter by threshold filter
%     for i = 1:length(scaled_peaks)
%         if scaled_peaks(i) < 4
%             scaled_peaks(i) = 0;
%         else
%             scaled_peaks(i) = 1;
%         end
%     end

     for i = 1:length(peaks)
        if peaks(i) < low  || peaks(i) > high
            scaled_peaks(i) = 0;
        else
            scaled_peaks(i) = 1;
        end
     end
    
     peak_locs = find(scaled_peaks);
     
                if debug
                    %   Mean Threshold Filtered (2-d pass)
                    subplot(5, 1, 5); 
                    plot(peak_locs, high_pass_filtered(peak_locs), 'go');
                    hold on
                    plot(1:length(high_pass_filtered), high_pass_filtered, 'r');
                    yPos = low;
                    plot(get(gca,'xlim'), [yPos yPos], 'b');                    
                    yPos = high;
                    plot(get(gca,'xlim'), [yPos yPos], 'b');
                    plot(get(gca,'xlim'), [m m], 'g');                    
                    hold off
                    title('\bf R-Peaks Detected - 2^d Pass - Threshold Filtered'); 
                    %ylim([0 1.4]);
                end
    
    drawnow
    
end

% END OF FILE