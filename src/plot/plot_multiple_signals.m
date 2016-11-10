
%------------------------------------------------------------------------
%                       PREPROCESSING PLOT
%------------------------------------------------------------------------                       

%  Copyright 2012 R. Eric McGregor

function preprocessing_plot(orig, decimated, normalized, filtered, id, signal_type, fig_handle)
    global undock_plots;
    global plot_panel;
    global pause_between_plots;
    global samplerate;

    maxHz = settings.maxHz;
    targetrate = settings.targetrate;
    apply_high_pass_filter = settings.apply_high_pass_filter;
    apply_notch_filter = settings.apply_notch_filter;
    use_displacement_signal = settings.use_displacement_signal;
    
    maxHz = settings.maxHz;
    targetrate = settings.targetrate;
    apply_high_pass_filter = settings.apply_high_pass_filter;
    apply_notch_filter = settings.apply_notch_filter;
    use_displacement_signal = settings.use_displacement_signal;
    
    num_plots = 1;
    cur_plot = 1;
    
    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize'))
    else
        arrayfun(@delete ,get(plot_panel,'children'));        
        axes('parent', plot_panel);
    end
       
    if targetrate ~= samplerate
        num_plots = num_plots + 1;
    end
    
    if apply_high_pass_filter
        num_plots = num_plots + 1;
    end
    
    if use_displacement_signal
        num_plots = num_plots + 1;
    end

    subplot(num_plots,1,cur_plot)
    plot(1:length(orig), orig, 'k')
    title({['\bf Subject ', num2str(id)]; 'Original Signal'});
    
    if targetrate ~= samplerate
        cur_plot = cur_plot + 1;
        subplot(num_plots,1,cur_plot)
        plot(1:length(decimated), decimated, 'g')
        title('\bf Decimated Signal');
    end
    
    if apply_high_pass_filter
        cur_plot = cur_plot + 1;
        subplot(num_plots,1,cur_plot)
        plot(1:length(normalized), normalized, 'r')
        title('\bf High Pass Filtered Signal');    
    end
    
    if use_displacement_signal
        cur_plot = cur_plot + 1;
        subplot(num_plots,1,cur_plot)
        plot(1:length(filtered), filtered, 'r')
        title('\bf Displacement Signal');
    end
    
    if apply_notch_filter
               
        if pause_between_plots
            fprintf('Press enter to continue\n');
            pause
        end
        
        arrayfun(@cla,findall(0,'type','axes'));
        
        % Plot power spectrum of normalized signal
        Y = fft(normalized);
        Pyy = Y.*conj(Y);
        g = linspace(0,targetrate,length(normalized));
        m = floor(maxHz*length(normalized)/targetrate);
        
        h2 = subplot(3,1,1);
        semilogy(g(1:m),Pyy(1:m),'r')
        grid on
        title('\bf Pre-Filter Power Spectral Density')
        %xlabel('Frequency (Hz)')

        subplot(3,1,2)
        plot(1:length(filtered), filtered, 'b')
        title('\bf Filtered Signal');    
                
        % Plot power spectrum of filtered signal
        Y = fft(filtered);
        Pyy = Y.*conj(Y);
        g = linspace(0,targetrate,length(filtered));
        m = floor(maxHz*length(filtered)/targetrate);
        
        h2 = subplot(3,1,3);
        semilogy(g(1:m),Pyy(1:m),'b')
        grid on
        title('\bf Post-Filter Power Spectral Density')
        %xlabel('Frequency (Hz)')       
    end
    
    drawnow
end

% END OF FILE