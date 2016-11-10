%-------------------------------------------------------------------------
%                      CALCULATE FEATURES
%-------------------------------------------------------------------------

function calculate_features(phase)
global training_trials;
global testing_trials;
global training_file_layout;
global testing_file_layout;
global training_delineator;
global testing_delineator;
global subject_model_dir;
global homogeneous_algorithm;
global training_data_dir;
global testing_data_dir;

% Local Variables

preprocessing_plot_handle = 200;
peak_detection_plot_handle = 201;
segment_selection_plot_handle = 202;
spectrograms_plot_handle = 203;
maximum_likeliness_plot_handle = 204;
entropy_scores_plot_handle = 205;
%train_and_test_data_plot_handle = 206;

try
    switch phase
        case 'train'
            dir_name = training_data_dir;
            file_layout = training_file_layout;
            delineator = training_delineator;
        case 'test'
            dir_name = testing_data_dir;
            file_layout = testing_file_layout;
            delineator = testing_delineator;
    end
    
    [selected_trials, modality] = get_trials_and_modality(training_trials, testing_trials, phase);
   
    if isempty(find(selected_trials, 1))
        fprintf('No trials selected.  Choose trials from the IO menu. \n');
        return;
    end
    
    switch modality
        case 'ecg'
            fprintf('Using ECG signals...\n');
        case 'ldv'
            fprintf('Using LDV signals...\n');
        case 'pcg'
            fprintf('Using PCG signals...\n');
    end
    
    recordings = load_recordings(modality, selected_trials, dir_name, file_layout, delineator);
    recordings = preprocess_recordings(recordings, phase, preprocessing_plot_handle);
    samples = segment_recordings(recordings, peak_detection_plot_handle);
    
    subjects = consolidate_segments(samples);
    
    subjects = generate_spectrograms(subjects, spectrograms_plot_handle);
    subjects = calculate_maximum_likelihood_estimates(subjects, maximum_likeliness_plot_handle); % nominal spectrogram
    
    subjects = select_segments(subjects, phase, segment_selection_plot_handle);
    

    if homogeneous_algorithm && strcmp(phase,'test')
        nominal_model_file_path = fullfile(subject_model_dir, 'training_nominal_model.mat');
        
        if exist(nominal_model_file_path) ~= 2
            fprintf('Can not test homogeneous model. Nominal model not found. Run training phase first.\n');
            return;
        end
        
        load(nominal_model_file_path);
        
    else
        nominal_model = calculate_nominal_model(subjects);
        
        fprintf('Saving nominal model...\n');
        switch phase
            case 'train'
                nominal_model_path = fullfile(subject_model_dir, 'training_nominal_model.mat');
            case 'test'
                nominal_model_path = fullfile(subject_model_dir, 'testing_nominal_model.mat');
        end
        
        save(nominal_model_path, 'nominal_model');
    end
    
    subjects = calculate_symmetric_relative_entropy_scores(subjects, nominal_model, entropy_scores_plot_handle);
    subjects = select_highest_entropy_bins(subjects);
    subjects = set_high_entropy_spectrograms(subjects);
    
    switch phase
        case 'train'
            data_path = fullfile(subject_model_dir, 'training_data.mat');
        case 'test'
            data_path = fullfile(subject_model_dir, 'testing_data.mat');
    end
    
    fprintf('Saving subject biometric data...\n');
    save(data_path, 'subjects');
    
catch err
    err.message
    disp('Error in calculate features.');
    rethrow(err);
end
end


% END OF FILE -----------------------------------------------------------


