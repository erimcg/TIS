%------------------------------------------------------------------------
%                       SVM
%------------------------------------------------------------------------
function svm(x_train, y_train, x_test, y_test)
    
    global cmin cstep cmax gmin gstep gmax;
    
    global undock_plots;
    global plot_panel;
    
    fprintf('Training and testing the Support Vector Machine...\n');
      
    accuracy = [];
    max_score = 0;
    
    for c = cmin:cstep:cmax;      
        for g = gmin:gstep:gmax
            if max_score == 100
                accuracy = [accuracy; [c, g, val_accuracy(1,1)]];
                continue;
            end
            
            fprintf('Testing c:%d and g:%d\n', c, g);

            % Create the options for the SMV classifier
            options = [' -c ', num2str(2^(c)), ' -g ', num2str(2^(g))];

            % Train the SMV
            model = svmtrain(y_train, x_train, options);

            % Test the SVM
            [class val_accuracy scores] = svmpredict(y_test, x_test, model);
            %val_accuracy
            if val_accuracy(1) > max_score
                max_score = val_accuracy(1);
                max_y_test = y_test;
                max_class = class;
                max_scores = scores;
            end
                                               
            accuracy = [accuracy; [c, g, val_accuracy(1,1)]];
        end           
    end
       
    accuracy_matrix = vec2mat(accuracy(:,3), length([gmin:gstep:gmax]));
    zmin = min(accuracy_matrix(:)); zmax = max(accuracy_matrix(:));

    if undock_plots
        figure('NumberTitle', 'off')
        set(gcf, 'Position', get(0,'Screensize')); 
    else
        delete(get(plot_panel,'children'));
        axes('parent', plot_panel);
    end

    surf(accuracy_matrix)
    colormap(copper)
    set(gca,'XTickLabel',[gmin:gstep:gmax], ...
        'YTickLabel',[cmin:cstep:cmax])

    xlabel('g Parameter')
    ylabel('c Parameter')
    zlabel('Segment Accuracy (%)')

    fprintf('\nMaximum Accuracy: %4.2f\n', max(accuracy(:,3)));
    
    subject_ids = unique(max_y_test);
    
    subject_scores = zeros(length(subject_ids), length(subject_ids));
    
    for i = 1:length(max_y_test)
        if max_y_test(i) ~= max_class(i)
            fprintf('Actual (%d) - Predicted (%d) \n', max_y_test(i), max_class(i));
        end
        
        actual_class = find(subject_ids == max_y_test(i));
        predicted_class = find(subject_ids == max_class(i));
        
        subject_scores(actual_class, predicted_class) = subject_scores(actual_class, predicted_class) + 1;
    end
     
    subject_scores
    
    num_true_matches = 0;
    
    for i = 1:length(subject_ids)
        fprintf(['Subject ', num2str(subject_ids(i)), ' - ']);
           
        if length(find(subject_scores(i,:) >= subject_scores(i,i))) > 1
            fprintf('False Match \n');
        else
            fprintf('True Match \n');
            num_true_matches = num_true_matches + 1;
        end
    end
    
    match_accuracy = num_true_matches / length(subject_ids) * 100;
    fprintf(['\nTrue Match Rate: ', num2str(match_accuracy), '%% \n']);

end



% END OF FILE -------------------------------------------------------------
