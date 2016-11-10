%--------------------------------------------------------------------------
%                      LLR CLASSIFIER FOR IDENTIFICATION
%--------------------------------------------------------------------------

function identify_using_llr(training_subjects, testing_subjects)
    global failure_to_enroll_in_training;
    global failure_to_enroll_in_testing;
    
    num_true_matches = 0;

    if length(training_subjects) ~= length(testing_subjects)
        fprintf('ERROR CALCULATING LLR\n');
        return;
    end
    
    for i = 1:length(testing_subjects)
        fprintf(['Subject ', num2str(testing_subjects(i).id), ' - ']);
        [~, max_index] = max(testing_subjects(i).llr_scores);           

        if testing_subjects(i).id ~= training_subjects(max_index).id
            fprintf('False Match (%d)\n', training_subjects(max_index).id);
        else
            fprintf('True Match \n');
            num_true_matches = num_true_matches + 1;
        end
    end
    
    match_accuracy = num_true_matches / length(testing_subjects) * 100;
    fprintf(['\nRank-1 Match Rate: ', num2str(match_accuracy), '%% \n']);
    
    ranking = zeros(length(testing_subjects(1).llr_scores),1);
    rank_k_count = zeros(length(testing_subjects(1).llr_scores),1);
    
    for i = 1:length(testing_subjects)
        llr_scores = testing_subjects(i).llr_scores;
        
        %rank the llr_scores for subject i
        
        for j = 1:length(llr_scores)
            [~, max_index] = max(llr_scores);
            ranking(max_index) = j;
            llr_scores(max_index) = -realmax;
        end
        
        %ranking(i) indicates the system found ranking(i)-1 individuals that were
        % more similar to i than i itself.
        
        rank_k_count(ranking(i)) = rank_k_count(ranking(i)) + 1;
    end    
    
    rank_k_count
    
    total = 0;
    for i = 1:length(rank_k_count)
        total = total + rank_k_count(i);
        fprintf('rank %d: %d\n', i, round((total/length(rank_k_count))*100));
    end
    
    if failure_to_enroll_in_training > 0
        fprintf('Failure to enroll in training: ', num2str(failure_to_enroll_in_training));
    end
    if failure_to_enroll_in_testing > 0
        fprintf('Failure to enroll in testing: ', num2str(failure_to_enroll_in_testing));
    end
end

