%------------------------------------------------------------------------
%                       GET TRIALS AND MODALITY
%------------------------------------------------------------------------

function [selected_trials, modality] = get_trials_and_modality(training_trials, testing_trials, phase)

    % phase: 'train' or 'test'
    % trail_selection_mode: 1 (neither), 2 (train), 3 (test), 4 (both);
    
    switch phase
        case 'train'
            fprintf('Calculating Training Features ...\n');     
            trial_selection_mode = 2;
        case 'test'
            fprintf('Calculating Testing Features ...\n'); 
            trial_selection_mode = 2;
              
    end      
  
    % --- Below, the switch statements were added and the trial number was
    % --- edited to match the global vars in set_options_vars
    
    modality = 'ecg';
    switch phase
        case 'train'
            selected_trials = (training_trials(1, 1:12) == trial_selection_mode) + ...
                (training_trials(1, 1:12) == 4);
        case 'test'
            selected_trials = (testing_trials(1,1:12) == trial_selection_mode) + ...
                (testing_trials(1, 1:12) == 4);
    end
    
    if isempty(find(selected_trials))
        modality = 'ldv';
        switch phase
            case 'train'
                selected_trials = (training_trials(2,1:12) == trial_selection_mode) + ...
                    (training_trials(2, 1:12) == 4);
            case 'test'
                selected_trials = (testing_trials(2,1:12) == trial_selection_mode) + ...
                    (testing_trials(2, 1:12) == 4);
        end
    end

    if isempty(find(selected_trials))
        modality = 'pcg';     
        switch phase
            case 'train'
                selected_trials = (training_trials(3,1:12) == trial_selection_mode) + ...
                    (training_trials(3, 1:12) == 4);            
            case 'test'
                selected_trials = (testing_trials(3,1:12) == trial_selection_mode) + ...
                    (testing_trials(3, 1:12) == 4);
        end
    end
end

