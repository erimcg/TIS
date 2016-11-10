
%------------------------------------------------------------------------
%                       ENTROPY SCORES PLOT
%------------------------------------------------------------------------ 

%  Copyright 2012 R. Eric McGregor

function entropy_scores_plot(id, subject_mean, subject_var, nominal_mean, nominal_var, scores, fig_handle)

    global time_indices freq_indices;
    global undock_plots plot_panel;

    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize')); 
    else
        arrayfun(@delete ,get(plot_panel,'children'));
        axes('parent', plot_panel);
    end
    
    arrayfun(@cla,findall(0,'type','axes'))
    
    t = time_indices;
    f = freq_indices;
    num_freq_bins = length(f);
    num_time_bins = length(t);

    subplot(5,1,1)
    imagesc(t,f(1:num_freq_bins),reshape(subject_mean, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title({['\bf Subject ' num2str(id)]; 'Subject Mean Spectrogram'}) 
    
    subplot(5,1,2)
    imagesc(t,f(1:num_freq_bins),reshape(nominal_mean, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title('\bf Nominal Mean Spectrogram')  
    
    subplot(5,1,3)
    imagesc(t,f(1:num_freq_bins),reshape(subject_var, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title('\bf Subject Spectrogram Bin Variances') 
    
    subplot(5,1,4)
    imagesc(t,f(1:num_freq_bins),reshape(nominal_var, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title('\bf Nominal Spectrogram Variances')  
    
    subplot(5,1,5)
    imagesc(t,f(1:num_freq_bins),reshape(scores, num_freq_bins, num_time_bins))
    colormap(gray)
    set(gca, 'YDir', 'normal')
    title('\bf Symmetric Relative Entropy Scores')
    
    drawnow
end

% END OF FILE

