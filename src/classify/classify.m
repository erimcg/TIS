function classify( )

    global subject_model_dir;
    global homogeneous_algorithm;
    global heterogeneous_algorithm;
    global identification_mode;
    global authentication_mode;
    global svm_classifier;
    global probabilistic_classifier;
    global plot_train_and_test_data;
    global ldv_settings;
    
    train_and_test_data_plot_handle = 206;
    
    fprintf('Classifying ...\n');  

    % Load Training Data
    file_path = fullfile(subject_model_dir, 'training_data.mat');
    load(file_path);
    training_subjects = subjects;
    
    file_path = fullfile(subject_model_dir, 'testing_data.mat');
    load(file_path);
    testing_subjects = subjects;
 
    file_path = fullfile(subject_model_dir, 'training_nominal_model.mat');
    load(file_path);
    training_nominal_model = nominal_model;
    
    [x_train y_train] = collect_high_entropy_spectrograms(training_subjects);
    [x_test y_test] = collect_high_entropy_spectrograms(testing_subjects);
    
    if plot_train_and_test_data
        train_and_test_spectrogram_plot(x_train, y_train, x_test, y_test, train_and_test_data_plot_handle);
    end
    
    if homogeneous_algorithm
        if identification_mode
            if svm_classifier            
                identify_using_svm(x_train, y_train, x_test, y_test);

            elseif probabilistic_classifier
                if ldv_settings.static_bin_selection
                    testing_subjects = calculate_llr_scores(training_subjects, testing_subjects, training_nominal_model);
                end
                identify_using_llr(training_subjects, testing_subjects);

            end
        elseif authentication_mode
                testing_subjects = calculate_llr_scores(training_subjects, testing_subjects, training_nominal_model);
                authenticate_using_llr(training_subjects, testing_subjects);        
        end
    elseif heterogeneous_algorithm
        disp('Heterogeneous option is not available at this time\n'); 
    end
end

