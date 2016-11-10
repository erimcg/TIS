function test_data = calculate_llr_scores(train_data, test_data, nominal_model)

    global num_bins;

    %   For each test subject, i, iterate through all of their test segments, j, and
    %   calculate score(i, j, k) where k is a subject in the training data set.
    
    fprintf('Calculating LLR scores ... \n');
    
    %For this subject, compute a score for each training subject.
    for i = 1:length(test_data)
        test_data(i).llr_scores = zeros(1, length(train_data));
        for j = 1:length(test_data(i).segments)
            
            % Using the mean and variance for training subject k, calculate
            % a score which indicates how close test subject i is to
            % training subject k.
            
            for k = 1:length(train_data)
                
                score_k = 0;
                
                for l = 1:num_bins
                    
                    if train_data(k).selected_bins(l) == 0
                        continue;
                    end
                    
                    m = train_data(k).mean(l);
                    v = sqrt(train_data(k).var(l));
                    p_k = normpdf(test_data(i).segments(j).spectrogram(l), m, v);
                    
                    
                    m_0 = nominal_model.mean(l);
                    v_0 = sqrt(nominal_model.var(l));
                    p_0 = normpdf(test_data(i).segments(j).spectrogram(l), m_0, v_0);
                    
                    ratio = p_k/p_0;
                    
                    if ratio == 0 || isnan(ratio)
                        if isnan(ratio)
                            fprintf('nan: m:%d, v:%d\n', m, train_data(k).var(l));
                        end
                        continue;
                    end
                    
                    score_k = score_k + log(ratio);
                    
                end
                
                test_data(i).llr_scores(k) = test_data(i).llr_scores(k) + score_k;
            end
        end
    end

    for k = 1:length(test_data(i).llr_scores)
        test_data(i).llr_scores(k) = test_data(i).llr_scores(k) / length(test_data(i).segments);
    end
    
    
    
    for i = 1:length(test_data)
        for j = 1:length(test_data(i).llr_scores)
            fprintf('%d ', test_data(i).llr_scores(j));
        end
        fprintf('\n');
    end
    fprintf('\n');
    
end

    

