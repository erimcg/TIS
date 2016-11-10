
%------------------------------------------------------------------------
%                       BEAT SELECTION PLOT
%------------------------------------------------------------------------

%  Copyright 2012 R. Eric McGregor

function choice = beat_selection_plot(select_manually, id, segment_index, num_segments_selected, num_segments_needed, selected_segments, signal, fig_handle, spectrogram, nominalSpectrogram)

    global time_indices;
    global freq_indices;
    global undock_plots;
    global plot_panel;

    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize'))
    else
        arrayfun(@delete ,get(plot_panel,'children'));
        axes('parent', plot_panel);
    end

    hold on

    % Plot segment index

    selected_segments(segment_index) = 1;

    subplot(4,1,1)
    bar(selected_segments, 1, 'b');
    axis([1 length(selected_segments) 0 1])
    set(gca, 'YTick', [])
    title({['\bf Subject ', num2str(id)]; 'Selected Segments'});
    xlabel('Segment Number');
    freezeColors
    axis on

    % Plot original signal

    h1 = subplot(4,1,2);
    plot(1:length(signal), signal, 'k')
    grid on
    axis('tight')
    title({['\bf Subject ', num2str(id)]; ['Segment ', num2str(num_segments_selected+1), ' of ', num2str(num_segments_needed)]})

    % Plot corresponding Spectrogram
    h2 = subplot(4,1,3);
    f = freq_indices;
    t = time_indices;
    num_freq_bins = length(f);
    num_time_bins = length(t);
    imagesc(t,f(1:num_freq_bins),reshape(spectrogram, num_freq_bins, num_time_bins));
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title({['\bf Subject ', num2str(id)]; ['Spectrogram ', num2str(num_segments_selected+1), ' of ', num2str(num_segments_needed)]})
    xlabel('FFT Windows')
    ylabel('Frequency (Hz)')
    drawnow

    % Plot nominal Spectrogram
    h3 = subplot(4,1,4);
    imagesc(t,f(1:num_freq_bins),reshape(nominalSpectrogram, num_freq_bins, num_time_bins));
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title({['\bf Subject ', num2str(id)]; ['Nominal Spectrogram']})
    xlabel('FFT Windows')
    ylabel('Frequency (Hz)')
    drawnow

    if select_manually
        choice = questdlg('Select beat?', 'Manual Beat Selection', 'Yes', 'No', 'Select Randomly', 'Yes');
    else
        choice = 'Default'
    end

    drawnow
end

% END OF FILE
