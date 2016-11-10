%------------------------------------------------------------------------
%                       CALCULATE MAXIMUM LIKELIHOOD ESTIMATES
%------------------------------------------------------------------------

function subjects = calculate_maximum_likelihood_estimates(subjects, maximum_likeliness_plot_handle)
    
    global num_bins;
    global plot_maximum_likeliness;
    global pause_between_plots;
    
    fprintf('Calculating maximum likelihood estimates ...\n');

    num_subjects = length(subjects);

    for i = 1:num_subjects

        id = subjects(i).id;
        spec_mean = zeros(1, num_bins);
        spec_var = zeros(1, num_bins);
        cur_bin_vals = zeros(1, length(subjects(i).segments));
                
        % Calculate spectrogram bin means 
        for j = 1:length(subjects(i).segments)
            cur_spec = subjects(i).segments(j).spectrogram;
            spec_mean = spec_mean + cur_spec;
            
            if plot_maximum_likeliness
                maximum_likeliness_plot(id, j, cur_spec, spec_mean, spec_var, maximum_likeliness_plot_handle);
            end
        end
        
        spec_mean = spec_mean ./ length(subjects(i).segments);
        subjects(i).mean = spec_mean;
        
        spec_var = zeros(size(spec_mean));
        
        % Calculate spectrogram bin variances
        for k = 1:num_bins
            cur_bin_vals = zeros(1, length(subjects(i).segments));
            
            for j = 1:length(subjects(i).segments)
                cur_spec = subjects(i).segments(j).spectrogram;
                cur_bin_vals(j) = cur_spec(k);
                
                if plot_maximum_likeliness
                    maximum_likeliness_plot(id, j, cur_spec, spec_mean, spec_var, maximum_likeliness_plot_handle);
                end
            end

            spec_var(k) = var(cur_bin_vals);

        end
        
        subjects(i).var = spec_var;
    end
    %%%%%%%%%%%%subjects(i).mean = spec_mean; --> USE THIS NOMINAL
    %%%%%%%%%%%%SPECTROGRAM TO DO DIFFERENCE ARRAY
    %%%%%%%  Calculate the differences and take the absolute value
   
    for i = 1:num_subjects
        for j = 1:length(subjects(i).segments)
            current_spectrogram = subjects(i).segments(j).spectrogram;
            %compare testing set with the nominal of training set
             
            segment_minus_nominal_spectrogram = abs(current_spectrogram - subjects(i).mean);
            subjects(i).segments(j).diff_matrix = segment_minus_nominal_spectrogram;
            sum_of_bins = sum(segment_minus_nominal_spectrogram);
            subjects(i).segments(j).difference = sum_of_bins;
        end
    end
       
    if plot_maximum_likeliness && pause_between_plots
        fprintf('Press enter to continue\n');
        pause
    end
end

