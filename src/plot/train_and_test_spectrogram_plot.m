%------------------------------------------------------------------
%                  TRAIN AND TEST SPECTROGRAM PLOT
%------------------------------------------------------------------

%  Copyright 2012 R. Eric McGregor

function train_and_test_spectrogram_plot(x_train, y_train, x_test, y_test, fig_handle)

    global undock_plots;
    global plot_panel;
    global pause_between_plots;
    global plot_train_and_test_data;
    
    global num_bins;
    global time_indices freq_indices;
    
    x_len = length(time_indices);
    y_len = length(freq_indices);
    
    if undock_plots
        figure(fig_handle)
        set(gcf, 'NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize')) 
    else
        arrayfun(@delete ,get(plot_panel,'children'));
        axes('parent', plot_panel);
    end
          
    test_ids = unique(y_test);
    
    for i = 1:length(test_ids)
        
        id = test_ids(i);
        test_indices = find(y_test == id);
        arrayfun(@cla,findall(0,'type','axes'));
        train_indices = find(y_train == id);
        
        for j = 1:length(train_indices)
            
            if ~plot_train_and_test_data
                return;
            end
            
            train_features = x_train(train_indices(j), 1:end);
            
            subplot(2,1,1)
            imagesc(1:x_len,1:y_len,reshape(train_features, y_len, x_len))
            colormap(flipud(gray))
            %caxis([0 1])
            set(gca, 'YDir', 'normal')
            title({['\bf Subject ' num2str(id)]; ['Training Feature Set ', num2str(j)]})
            
            drawnow
            
            if pause_between_plots
                fprintf('Press enter to continue\n');
                pause
            end
        end
        
        for j = 1:length(test_indices)
            
            if ~plot_train_and_test_data
                return;
            end
            
            test_features = x_test(test_indices(j), 1:end);
            
            subplot(2,1,2)
            imagesc(1:x_len,1:y_len, reshape(test_features, y_len, x_len))
            colormap(flipud(gray))
            %caxis([0 1])
            set(gca, 'YDir', 'normal')
            title(['Testing Feature Set ', num2str(j)])
            
            drawnow
            
            if pause_between_plots
                fprintf('Press enter to continue\n');
                pause
            end
        end
        

        
    end
            
    if pause_between_plots 
        fprintf('Press enter to continue\n');
        pause
    end
    
end


% END OF FILE

