
%------------------------------------------------------------------------
%                       MULTIPLOT
%------------------------------------------------------------------------                       

%  Copyright 2012 R. Eric McGregor

function multiplot(plots, fig_handle)
    global undock_plots;
    global plot_panel;
    
    n = length(plots);
    arrayfun(@cla,findall(0,'type','axes'));
    
    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize'))
    else
        arrayfun(@delete ,get(plot_panel,'children'));        
        axes('parent', plot_panel);
    end
    
    for i = 1:n
        subplot(n,1,i)
        plot(1:length(plots(i).signal), plots(i).signal, 'k')
        title(plots(i).title);
    end    
    
    drawnow    
end

% END OF FILE