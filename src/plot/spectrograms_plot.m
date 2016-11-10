
%------------------------------------------------------------------------
%                       SPECTROGRAMS PLOT 
%------------------------------------------------------------------------                       

%  Copyright 2012 R. Eric McGregor

function spectrograms_plot(id, segment_num, signal, settings, spectrogram, fig_handle)

    global time_indices freq_indices;
    global undock_plots plot_panel;

    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize'))
    else
        arrayfun(@delete ,get(plot_panel,'children'));        
        axes('parent', plot_panel);
    end
    
    hold on

        
    targetrate = settings.targetrate;
    maxHz = settings.maxHz;
    window_len = settings.window_len;
    step = settings.step;
    
    % Plot original signal
    h1 = subplot(3,1,1);
    plot(1:length(signal), signal, '.');
    grid on
    axis('tight')
    title({['\bf Subject ', num2str(id)]; ['Signal Segment ', num2str(segment_num)]});

    % Plot power spectrum of original signal
    Y = fft(signal);
    Pyy = Y.*conj(Y);
    g = linspace(0,targetrate,length(signal));
    m = floor(maxHz*length(signal)/targetrate);

    h2 = subplot(3,1,2);
    semilogy(g(1:m),Pyy(1:m),'k')
    grid on
    title('\bf Power Spectral Density')
    xlabel('Frequency (Hz)')

    t = time_indices;
    f = freq_indices;
    num_freq_bins = length(f);
    num_time_bins = length(t);

    subplot(3,1,3)
    imagesc(t,f(1:num_freq_bins),reshape(spectrogram, num_freq_bins, num_time_bins))

    colormap(gray)
    %colorbar
    set(gca, 'YDir', 'normal') 
    title('\bf Spectrogram')
    xlabel({'FFT Windows'; ['(window length-', num2str(window_len), ', step-' num2str(step), ')']})
    ylabel('Frequency (Hz)')
    
    drawnow
end

% END OF FILE

