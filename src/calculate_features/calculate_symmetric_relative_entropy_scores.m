%------------------------------------------------------------------------
%               CALCULATE SYMMETRIC RELATIVE ENTROPY SCORES
%------------------------------------------------------------------------
function subjects = calculate_symmetric_relative_entropy_scores(subjects, nominal_model, entropy_scores_plot_handle)

    global num_bins;
    global plot_entropy_scores;
    global pause_between_plots;

    num_subjects = length(subjects);
    
    s = subjects;
    m = nominal_model.mean;
    v = nominal_model.var;
    
    fprintf('Calculating symmetric relative entropy scores...\n');
    
    for i = 1:num_subjects
        id = subjects(i).id;
        bin_scores = zeros(1, num_bins);
        
        % --- Calculates Entropy Score for each bin for the Subject --- %
        for l = 1:num_bins
            bin_scores(l) = ((s(i).var(l) + (s(i).mean(l) - m(l))^2) / (2*v(l))) + ...
                ((v(l) + (s(i).mean(l) - m(l))^2) / (2*s(i).var(l))) - 1;
        end
        
        if plot_entropy_scores
            entropy_scores_plot(id, s(i).mean, s(i).var, m, v, bin_scores, entropy_scores_plot_handle);
        end
        
        subjects(i).entropy_scores = bin_scores;
    end
    
    if plot_entropy_scores && pause_between_plots
        fprintf('Press enter to continue\n');
        pause
    end
end

