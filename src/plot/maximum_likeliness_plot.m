
%------------------------------------------------------------------------
%                       MAXIMUM LIKELINESS PLOT 
%------------------------------------------------------------------------                       

%  Copyright 2012 R. Eric McGregor

function maximum_likeliness_plot(id, segment_num, spec, spec_mean, spec_var, fig_handle)
    
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

    % Plot spectrogram
    t = time_indices;
    f = freq_indices;
    num_freq_bins = length(f);
    num_time_bins = length(t);

    subplot(3,1,1)
    imagesc(t,f(1:num_freq_bins),reshape(spec, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal') 
    title({['\bf Subject ', num2str(id)]; ['Spectrogram: Segment ', num2str(segment_num)]})
    
    % Plot subject mean spectrogram  
    subplot(3,1,2)
    imagesc(t,f(1:num_freq_bins),reshape(spec_mean, num_freq_bins, num_time_bins))   
    colormap(gray)
    set(gca, 'YDir', 'normal') 
    title('\bf Mean Spectrogram')
      
    % Plot variances  
    subplot(3,1,3)
    imagesc(t,f(1:num_freq_bins),reshape(spec_var, num_freq_bins, num_time_bins))   
    colormap(gray)
    set(gca, 'YDir', 'normal') 
    title('\bf Bin Variances')
  
    drawnow
end

% END OF FILE

