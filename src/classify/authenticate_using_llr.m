%--------------------------------------------------------------------------
%                      LLR CLASSIFIER FOR AUTHENTICATION
%--------------------------------------------------------------------------

function authenticate_using_llr(training_subjects, testing_subjects)
    global failure_to_enroll_in_training;
    global failure_to_enroll_in_testing;
    global ecg_settings;
    global ldv_settings;
    
    threshold = 0;
    
    num_true_accept = 0;
    num_true_reject = 0;
    num_false_accept = 0;
    num_false_reject = 0;
    
    if length(training_subjects) ~= length(testing_subjects)
        fprintf('ERROR CALCULATING LLR\n');
        return;
    end
    
    switch training_subjects(1).signal_type
        case 'ecg'
            threshold = ecg_settings.threshold;
        case 'ldv'
            threshold = ldv_settings.threshold;
    end
    
    for i = 1:length(testing_subjects)
        for j = 1:length(testing_subjects(1).llr_scores)
            if testing_subjects(i).llr_scores(j) > threshold && (i == j)
                %fprintf(['Subject ', num2str(testing_subjects(i).id), ' - ']);  
                %fprintf('True Accept \n');
                num_true_accept = num_true_accept + 1;
            elseif testing_subjects(i).llr_scores(j) > threshold && (i ~= j)
                %fprintf(['Subject ', num2str(testing_subjects(i).id), ' - ']);
                %fprintf('False Accept (score: %d)\n', testing_subjects(i).llr_scores(i));
                num_false_accept = num_false_accept + 1;
            elseif testing_subjects(i).llr_scores(j) <= threshold && (i == j)
                fprintf(['Subject ', num2str(testing_subjects(i).id), ' - ']);
                fprintf('False Reject (score: %d)\n', testing_subjects(i).llr_scores(i));
                num_false_reject = num_false_reject + 1;
            elseif testing_subjects(i).llr_scores(j) <= threshold && (i ~= j)
                %fprintf(['Subject ', num2str(testing_subjects(i).id), ' - ']);
                %fprintf('True Reject \n');
                num_true_reject = num_true_reject + 1;                
            end
        end
    end
    
    num_tests = num_true_accept + num_true_reject + num_false_accept + num_false_reject;
    num_subjects = length(testing_subjects);
    num_impostors = num_tests - num_subjects;
    
    fprintf('\nThreshold: %d\n\n', threshold);
    
    disp('Authorized');
    fprintf('True Accept - %d (%.2f)\n', num_true_accept, num_true_accept/num_subjects*100);
    fprintf('False Reject - %d (%.2f)\n\n', num_false_reject, num_false_reject/num_subjects*100);
    
    disp('Impostors');
    fprintf('True Reject - %d (%.2f)\n', num_true_reject, num_true_reject/num_impostors*100);
    fprintf('False Accept - %d (%.2f)\n\n', num_false_accept, num_false_accept/num_impostors*100);  
    
    if failure_to_enroll_in_training > 0
        fprintf('Failure to enroll in training: %d', num2str(failure_to_enroll_in_training));
    end
    
    if failure_to_enroll_in_testing > 0
        fprintf('Failure to enroll in testing: %d', num2str(failure_to_enroll_in_testing));
    end
end

