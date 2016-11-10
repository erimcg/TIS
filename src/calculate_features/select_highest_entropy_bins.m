%------------------------------------------------------------------------
%                       SELECT HIGHEST ENTROPY BINS
%------------------------------------------------------------------------
function subjects = select_highest_entropy_bins(subjects)
   
    global num_bins;
     
    global ecg_settings;
    global ldv_settings;
    
    fprintf('Selecting highest entropy bins ...\n');
    
    % Calculate subject's feature template using entropy scores
    for i = 1:length(subjects)
        switch subjects(i).signal_type
            case 'ecg'
                settings = ecg_settings;
            case 'ldv'
                settings = ldv_settings;
            case 'pcg'
                disp('Unable to segment pcg signals at this time.');
        end
        
        num_selected_bins = settings.num_selected_bins;
        
        if ldv_settings.static_bin_selection
            subjects(i).selected_bins = zeros(1, num_bins);
            entropy_scores = subjects(i).entropy_scores;
            
            for k = 1:num_selected_bins
                [~, max_index] = max(entropy_scores);
                subjects(i).selected_bins(max_index) = 1;
                entropy_scores(max_index) = 0;
            end
        else    %---Dynamic Bin Selection---%
            for j = 1:length(subjects(i).segments)
                subjects(i).segments(j).selected_bins = zeros(1, num_bins);
                entropy_scores = subjects(i).segments(j).diff_matrix;
                
                for k = 1:num_selected_bins
                    [~, min_index] = min(entropy_scores);
                    subjects(i).segments(j).selected_bins(min_index) = 1;
                    entropy_scores(min_index) = intmax;
                end
            end
        end
    end
end

