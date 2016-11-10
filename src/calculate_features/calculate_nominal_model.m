%------------------------------------------------------------------------
%                       CALCULATE NOMINAL MODEL
%------------------------------------------------------------------------
function nominal_model = calculate_nominal_model(subjects)
    
    global num_bins;
    
    fprintf('Calculating nominal model ...\n');
    
    mean_spec = zeros(1, num_bins);
    num_subjects = length(subjects);
    num_samples = 0;

    for i = 1:num_subjects
        for j = 1:length(subjects(i).segments)
                mean_spec = mean_spec + subjects(i).segments(j).spectrogram;
                num_samples = num_samples + 1;
        end


    end

    nominal_model.mean = mean_spec ./ num_samples;
    
    variances = zeros(1, num_bins);
    
    for k = 1:num_bins
        cur_bin_vals = zeros(1, num_samples);
        cur_index = 0;
            
        for i = 1:num_subjects
            for j = 1:length(subjects(i).segments)
                cur_index = cur_index + 1;
                cur_bin_vals(cur_index) = subjects(i).segments(j).spectrogram(k);
            end
        end
        
        variances(k) = var(cur_bin_vals);     
        
    end
    
    nominal_model.var = variances;
end

