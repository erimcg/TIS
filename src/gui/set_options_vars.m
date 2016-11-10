function  set_options_vars

    %--------------------------------------------------------------
    % --------------------- Model Options---------------------
    %--------------------------------------------------------------  

    global identification_mode;
    global authentication_mode;
    
    global homogeneous_algorithm;
    global heterogeneous_algorithm;
    
    global probabilistic_classifier;   
    global svm_classifier;     
    
    global cmin;
    global cstep;
    global cmax;

    global gmin;
    global gstep;
    global gmax;    
    
    global subject_model_dir;
    global hetero_model_dir;
    global homo_model_dir;
    
    global model_options_panel;
    options_panel_children = get(model_options_panel, 'children');

    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
         
            case 'system_mode'
                val = get(options_panel_children(i),'Value'); 
                str = get(options_panel_children(i),'String');
                switch str{val};
                    case 'Identification'
                        identification_mode = 1;
                        authentication_mode = 0;
                    case 'Authentication'
                        identification_mode = 0;
                        authentication_mode = 1;
                end                
            
            case 'algorithm_type'
                val = get(options_panel_children(i),'Value'); 
                str = get(options_panel_children(i),'String');
                switch str{val};
                    case 'Heterogeneous'
                        heterogeneous_algorithm = 1;
                        homogeneous_algorithm = 0;
                    case 'Homogeneous'
                        heterogeneous_algorithm = 0;
                        homogeneous_algorithm = 1;
                end
            
            case 'classifier_type'
                val = get(options_panel_children(i),'Value'); 
                str = get(options_panel_children(i),'String');
                switch str{val};
                    case 'Probabilistic'
                        probabilistic_classifier = 1;
                        svm_classifier = 0;
                    case 'Support Vector Machine'
                        probabilistic_classifier = 0;
                        svm_classifier = 1;
                end                  
            case 'cmin'
                cmin = str2num(get(options_panel_children(i),'String'));
            case 'cstep'
                cstep = str2num(get(options_panel_children(i),'String'));
            case 'cmax'
                cmax = str2num(get(options_panel_children(i),'String'));
            case 'gmin'
                gmin = str2num(get(options_panel_children(i),'String'));
            case 'gstep'
                gstep = str2num(get(options_panel_children(i),'String'));
            case 'gmax'
                gmax = str2num(get(options_panel_children(i),'String'));                        
        end
    end
    
    for i = 1:length(options_panel_children)
       switch get(options_panel_children(i), 'tag') 
           case 'subject_model_dir'
               subject_model_dir = get(options_panel_children(i),'String');   
           case 'hetero_model_dir'
               hetero_model_dir = get(options_panel_children(i),'String');
           case 'homo_model_dir'
               homo_model_dir = get(options_panel_children(i),'String');
        end
    end
    %--------------------------------------------------------------
    % -------------------  Training Options   ---------------------
    %--------------------------------------------------------------
    
    global training_options_panel;
    global training_delineator;
    global training_samplerate;
    global training_data_dir;  
    global training_file_layout;
    global training_trials;
    
    training_trials = zeros(3,12);
    
    options_panel_children = get(training_options_panel, 'children');
    
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'training_data_dir'
               training_data_dir = get(options_panel_children(i),'String');
            case 'training_delineator'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Tab'
                        training_delineator.tab = 1;
                        training_delineator.comma = 0;
                    case 'Comma'
                        training_delineator.tab = 0;
                        training_delineator.comma = 1;
                end
            case 'training_samplerate'
                training_samplerate = str2num(get(options_panel_children(i),'String'));
                
            case 'time_stamp'
                training_file_layout.tstamp_col = str2num(get(options_panel_children(i), 'String'));
            case 'ecg_layout'
                training_file_layout.ecg_col = str2num(get(options_panel_children(i), 'String'));
            case 'ldv_layout'
                training_file_layout.ldv_col = str2num(get(options_panel_children(i), 'String'));
            case 'pcg_layout'
                training_file_layout.pcg_col = str2num(get(options_panel_children(i), 'String'));
              
            case 'ecg_1_1'
                training_trials(1,1) = get(options_panel_children(i), 'Value');
            case 'ecg_1_2'
                training_trials(1,2) = get(options_panel_children(i), 'Value');
            case 'ecg_1_3'
                training_trials(1,3) = get(options_panel_children(i), 'Value');
            case 'ecg_1_4'
                training_trials(1,4) = get(options_panel_children(i), 'Value');                
            case 'ecg_1_5'
                training_trials(1,5) = get(options_panel_children(i), 'Value');
            case 'ecg_1_6'
                training_trials(1,6) = get(options_panel_children(i), 'Value');
            case 'ecg_1_7'
                training_trials(1,7) = get(options_panel_children(i), 'Value');
            case 'ecg_1_8'
                training_trials(1,8) = get(options_panel_children(i), 'Value');
            case 'ecg_1_9'
                training_trials(1,9) = get(options_panel_children(i), 'Value');
            case 'ecg_1_10'
                training_trials(1,10) = get(options_panel_children(i), 'Value');
            case 'ecg_1_11'
                training_trials(1,11) = get(options_panel_children(i), 'Value');
            case 'ecg_1_12'
                training_trials(1,12) = get(options_panel_children(i), 'Value');
                
            case 'ldv_1_1'
                training_trials(2,1) = get(options_panel_children(i), 'Value');
            case 'ldv_1_2'
                training_trials(2,2) = get(options_panel_children(i), 'Value');
            case 'ldv_1_3'
                training_trials(2,3) = get(options_panel_children(i), 'Value');
            case 'ldv_1_4'
                training_trials(2,4) = get(options_panel_children(i), 'Value');                
            case 'ldv_1_5'
                training_trials(2,5) = get(options_panel_children(i), 'Value');
            case 'ldv_1_6'
                training_trials(2,6) = get(options_panel_children(i), 'Value');
            case 'ldv_1_7'
                training_trials(2,7) = get(options_panel_children(i), 'Value');
            case 'ldv_1_8'
                training_trials(2,8) = get(options_panel_children(i), 'Value');
            case 'ldv_1_9'
                training_trials(2,9) = get(options_panel_children(i), 'Value');
            case 'ldv_1_10'
                training_trials(2,10) = get(options_panel_children(i), 'Value');
            case 'ldv_1_11'
                training_trials(2,11) = get(options_panel_children(i), 'Value');
            case 'ldv_1_12'
                training_trials(2,12) = get(options_panel_children(i), 'Value');             
                                 
            case 'pcg_1_1'
                training_trials(3,1) = get(options_panel_children(i), 'Value');
            case 'pcg_1_2'
                training_trials(3,2) = get(options_panel_children(i), 'Value');
            case 'pcg_1_3'
                training_trials(3,3) = get(options_panel_children(i), 'Value');
            case 'pcg_1_4'
                training_trials(3,4) = get(options_panel_children(i), 'Value');                
            case 'pcg_1_5'
                training_trials(3,5) = get(options_panel_children(i), 'Value');
            case 'pcg_1_6'
                training_trials(3,6) = get(options_panel_children(i), 'Value');
            case 'pcg_1_7'
                training_trials(3,7) = get(options_panel_children(i), 'Value');
            case 'pcg_1_8'
                training_trials(3,8) = get(options_panel_children(i), 'Value');
            case 'pcg_1_9'
                training_trials(3,9) = get(options_panel_children(i), 'Value');
            case 'pcg_1_10'
                training_trials(3,10) = get(options_panel_children(i), 'Value');
            case 'pcg_1_11'
                training_trials(3,11) = get(options_panel_children(i), 'Value');
            case 'pcg_1_12'
                training_trials(3,12) = get(options_panel_children(i), 'Value'); 
        end
    end
    
    % -------------------------------------------------------------------
    % -------------------   Testing Options   ---------------------------
    % -------------------------------------------------------------------
    
    global testing_options_panel;

    
    global testing_data_dir;
    global testing_delineator;
    global testing_samplerate;
    global testing_file_layout;
    global testing_trials;

    testing_trials = zeros(3,12);
    
    options_panel_children = get(testing_options_panel, 'children'); 
    
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'testing_data_dir'
                testing_data_dir = get(options_panel_children(i),'String');
            case 'testing_delineator'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Tab'
                        testing_delineator.tab = 1;
                        testing_delineator.comma = 0;
                    case 'Comma'
                        testing_delineator.tab = 0;
                        testing_delineator.comma = 1;
                end
            case 'testing_samplerate'
                testing_samplerate = str2num(get(options_panel_children(i),'String'));
                
            case 'testing_time_stamp'
                testing_file_layout.tstamp_col = str2num(get(options_panel_children(i), 'String'));
            case 'testing_ecg_layout'
                testing_file_layout.ecg_col = str2num(get(options_panel_children(i), 'String'));
            case 'testing_ldv_layout'
                testing_file_layout.ldv_col = str2num(get(options_panel_children(i), 'String'));
            case 'testing_pcg_layout'
                testing_file_layout.pcg_col = str2num(get(options_panel_children(i), 'String'));
  
            case 'ecg_2_1'
                testing_trials(1,1) = get(options_panel_children(i), 'Value');
            case 'ecg_2_2'
                testing_trials(1,2) = get(options_panel_children(i), 'Value');
            case 'ecg_2_3'
                testing_trials(1,3) = get(options_panel_children(i), 'Value');
            case 'ecg_2_4'
                testing_trials(1,4) = get(options_panel_children(i), 'Value');                
            case 'ecg_2_5'
                testing_trials(1,5) = get(options_panel_children(i), 'Value');
            case 'ecg_2_6'
                testing_trials(1,6) = get(options_panel_children(i), 'Value');
            case 'ecg_2_7'
                testing_trials(1,7) = get(options_panel_children(i), 'Value');
            case 'ecg_2_8'
                testing_trials(1,8) = get(options_panel_children(i), 'Value');
            case 'ecg_2_9'
                testing_trials(1,9) = get(options_panel_children(i), 'Value');
            case 'ecg_2_10'
                testing_trials(1,10) = get(options_panel_children(i), 'Value');
            case 'ecg_2_11'
                testing_trials(1,11) = get(options_panel_children(i), 'Value');
            case 'ecg_2_12'
                testing_trials(1,12) = get(options_panel_children(i), 'Value'); 
                
            case 'ldv_2_1'
                testing_trials(2,1) = get(options_panel_children(i), 'Value');
            case 'ldv_2_2'
                testing_trials(2,2) = get(options_panel_children(i), 'Value');
            case 'ldv_2_3'
                testing_trials(2,3) = get(options_panel_children(i), 'Value');
            case 'ldv_2_4'
                testing_trials(2,4) = get(options_panel_children(i), 'Value');                
            case 'ldv_2_5'
                testing_trials(2,5) = get(options_panel_children(i), 'Value');
            case 'ldv_2_6'
                testing_trials(2,6) = get(options_panel_children(i), 'Value');
            case 'ldv_2_7'
                testing_trials(2,7) = get(options_panel_children(i), 'Value');
            case 'ldv_2_8'
                testing_trials(2,8) = get(options_panel_children(i), 'Value');
            case 'ldv_2_9'
                testing_trials(2,9) = get(options_panel_children(i), 'Value');
            case 'ldv_2_10'
                testing_trials(2,10) = get(options_panel_children(i), 'Value');
            case 'ldv_2_11'
                testing_trials(2,11) = get(options_panel_children(i), 'Value');
            case 'ldv_2_12'
                testing_trials(2,12) = get(options_panel_children(i), 'Value');                
                           
            case 'pcg_2_1'
                testing_trials(3,1) = get(options_panel_children(i), 'Value');
            case 'pcg_2_2'
                testing_trials(3,2) = get(options_panel_children(i), 'Value');
            case 'pcg_2_3'
                testing_trials(3,3) = get(options_panel_children(i), 'Value');
            case 'pcg_2_4'
                testing_trials(3,4) = get(options_panel_children(i), 'Value');                
            case 'pcg_2_5'
                testing_trials(3,5) = get(options_panel_children(i), 'Value');
            case 'pcg_2_6'
                testing_trials(3,6) = get(options_panel_children(i), 'Value');
            case 'pcg_2_7'
                testing_trials(3,7) = get(options_panel_children(i), 'Value');
            case 'pcg_2_8'
                testing_trials(3,8) = get(options_panel_children(i), 'Value');
            case 'pcg_2_9'
                testing_trials(3,9) = get(options_panel_children(i), 'Value');
            case 'pcg_2_10'
                testing_trials(3,10) = get(options_panel_children(i), 'Value');
            case 'pcg_2_11'
                testing_trials(3,11) = get(options_panel_children(i), 'Value');
            case 'pcg_2_12'
                testing_trials(3,12) = get(options_panel_children(i), 'Value');               
        end
        
        
    end

    %--------------------------------------------------------------
    % --------------------- ECG Options---------------------
    %--------------------------------------------------------------

    global ecg_settings;
    ecg_settings = {};

    global ecg_preprocessing_options_panel;
    options_panel_children = get(ecg_preprocessing_options_panel, 'children');
    
    
    
   %%%%%%%%%%%ORIGINAL
%     for i = 1:length(options_panel_children)
%         switch get(options_panel_children(i), 'tag')
%             case 'targetrate'
%                 ecg_settings.targetrate = str2num(get(options_panel_children(i),'String'));
%             case 'apply_high_pass_filter'
%                 ecg_settings.apply_high_pass_filter = get(options_panel_children(i),'Value');
%             case 'apply_notch_filter' 
%                 ecg_settings.apply_notch_filter = get(options_panel_children(i),'Value');
%         end
%     end     
    
       %%%%%%%%%%UPDATED FROM ABOVE COMMENTED SECTION
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'targetrate'
                ecg_settings.targetrate = str2num(get(options_panel_children(i),'String'));
            case 'window_size'
                ecg_settings.window_size = str2num(get(options_panel_children(i),'String'));  
            case 'apply_trim_filter'
                ecg_settings.apply_trim_filter = get(options_panel_children(i),'Value');
            case 'apply_notch_filter' 
                ecg_settings.apply_notch_filter = get(options_panel_children(i),'Value');
        end
    end 
    
    global ecg_feature_set_options_panel;  
    options_panel_children = get(ecg_feature_set_options_panel, 'children');
   
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'num_segments_per_beat'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case '1'
                        ecg_settings.num_segments_per_beat = 1;
                    case '2'
                        ecg_settings.num_segments_per_beat = 2;
                end
            case 'segment_boundaries'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Fixed Length Relative to Peaks'
                        ecg_settings.fixed_length_boundaries = 1;
                        ecg_settings.peak_boundaries = 0;
                    case 'Peak to Peak'
                        ecg_settings.peak_boundaries = 1;
                        ecg_settings.fixed_length_boundaries = 0;
                end                
            case 'before_primary_peak_segment_length'
                ecg_settings.before_primary_peak_segment_length = str2num(get(options_panel_children(i),'String'));                
            case 'after_primary_peak_segment_length'
                ecg_settings.after_primary_peak_segment_length = str2num(get(options_panel_children(i),'String'));
            case 'before_secondary_peak_segment_length'
                ecg_settings.before_secondary_peak_segment_length = str2num(get(options_panel_children(i),'String'));                
            case 'after_secondary_peak_segment_length'
                ecg_settings.after_secondary_peak_segment_length = str2num(get(options_panel_children(i),'String'));

            case 'segment_selection_mode'
                ecg_settings.segment_selection_mode = get(options_panel_children(i),'String');
            case 'num_segments_per_training_subject'
                ecg_settings.num_segments_per_training_subject = str2num(get(options_panel_children(i),'String'));
            case 'num_segments_per_test_subject'
                ecg_settings.num_segments_per_test_subject = str2num(get(options_panel_children(i),'String'));                 
            case 'num_segments_per_test' 
                ecg_settings.num_segments_per_test = str2num(get(options_panel_children(i),'String'));
                
            case 'step'
                ecg_settings.step = str2num(get(options_panel_children(i),'String'));
            case 'window_len'
                ecg_settings.window_len = str2num(get(options_panel_children(i),'String'));
            case 'window'
                window_len_handle = find_child_by_tag(ecg_feature_set_options_panel, 'window_len');
                if window_len_handle > 0
                    ecg_settings.window_len = str2num(get(window_len_handle,'String'));
                    
                    val = get(options_panel_children(i),'Value');
                    if val == 1
                       ecg_settings.window =  hamming(ecg_settings.window_len);
                    elseif val == 2
                        ecg_settings.window = hanning(ecg_settings.window_len);
                    end
                end   
            
            case 'feature_selection'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Fixed Number'
                        ecg_settings.fixed_number_of_features = 1;
                    case 'Threshold'
                        ecg_settings.fixed_number_of_features = 0;
                end
            case 'num_selected_bins'
                ecg_settings.num_selected_bins = str2num(get(options_panel_children(i),'String'));
            case 'maxHz'
                ecg_settings.maxHz = str2num(get(options_panel_children(i),'String'));
            case 'threshold'
                ecg_settings.threshold = str2num(get(options_panel_children(i),'String'));
        end
    end

    %--------------------------------------------------------------
    % --------------------- LDV Options----------------------------
    %--------------------------------------------------------------

    global ldv_settings;
    ldv_settings = {};

    global ldv_preprocessing_options_panel;
    options_panel_children = get(ldv_preprocessing_options_panel, 'children');
   
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'downsample_method'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Chebyshev Filter'
                        ldv_settings.chebyshev_filter = 1;
                        ldv_settings.median_slide = 0;
                    case 'Median Slide'
                        ldv_settings.chebyshev_filter = 0;
                        ldv_settings.median_slide = 1;
                end
            case 'targetrate'
                ldv_settings.targetrate = str2num(get(options_panel_children(i),'String'));
            case'apply_high_pass_filter'
                ldv_settings.apply_high_pass_filter = get(options_panel_children(i), 'Value');
            case 'apply_trim_filter'
                ldv_settings.apply_trim_filter = get(options_panel_children(i),'Value');
            case 'remove_dropouts'
                ldv_settings.remove_dropouts = get(options_panel_children(i),'Value');
            case 'peak_detect_alg'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                ldv_settings.peak_detect_alg = str{val};
        end
    end


    
    global ldv_feature_set_options_panel;
    options_panel_children = get(ldv_feature_set_options_panel, 'children');
    
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'use_displacement_signal'
                ldv_settings.use_displacement_signal = get(options_panel_children(i),'Value');
            case 'step'
                ldv_settings.step = str2num(get(options_panel_children(i),'String'));
            case 'window_len'
                ldv_settings.window_len = str2num(get(options_panel_children(i),'String'));
            case 'window'
                window_len_handle = find_child_by_tag(ldv_feature_set_options_panel, 'window_len');
                if window_len_handle > 0
                    ldv_settings.window_len = str2num(get(window_len_handle,'String'));
                    
                    val = get(options_panel_children(i),'Value');
                    if val == 1
                       ldv_settings.window =  hamming(ldv_settings.window_len);
                    elseif val == 2
                        ldv_settings.window = hanning(ldv_settings.window_len);
                    end
                end    
                
            case 'segment_selection_mode'
                str = get(options_panel_children(i), 'String');
                index = get(options_panel_children(i), 'Value');
                ldv_settings.segment_selection_mode = str{index};
            case 'num_segments_per_training_subject'
                ldv_settings.num_segments_per_training_subject = str2num(get(options_panel_children(i),'String'));
            case 'num_segments_per_test_subject'
                ldv_settings.num_segments_per_test_subject = str2num(get(options_panel_children(i),'String'));
                
            case 'feature_selection'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Fixed Number'
                        ldv_settings.fixed_number_of_features = 1;
                    case 'Threshold'
                        ldv_settings.fixed_number_of_features = 0;
                end
            case 'bin_selection_method'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Static'
                        ldv_settings.static_bin_selection = 1;
                        ldv_settings.dynamic_bin_selection = 0;
                    case 'Dynamic'
                        ldv_settings.static_bin_selection = 0;
                        ldv_settings.dynamic_bin_selection = 1;
                end
            case 'num_selected_bins'
                ldv_settings.num_selected_bins = str2num(get(options_panel_children(i),'String'));
            case 'maxHz'
                ldv_settings.maxHz = str2num(get(options_panel_children(i),'String'));
            case 'threshold'
                ldv_settings.threshold = str2num(get(options_panel_children(i),'String'));    
        end
    end
    
    %ldv_settings.apply_notch_filter = 0;
    
    global ldv_segmentation_options_panel;
    options_panel_children = get(ldv_segmentation_options_panel, 'children');
    
    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')  
             case 'window_size'
                ldv_settings.window_size = str2num(get(options_panel_children(i),'String')); 
            case 'num_segments_per_beat'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case '1'
                        ldv_settings.num_segments_per_beat = 1;
                    case '2'
                        ldv_settings.num_segments_per_beat = 2;
                end
            case 'segment_boundaries'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');
                switch str{val};
                    case 'Fixed Length Beginning From Peak'
                        ldv_settings.fixed_length = 1;
                        ldv_settings.fixed_length_boundaries = 0;
                        ldv_settings.peak_boundaries = 0;                        
                    case 'Fixed Lengths Before and After Peak'
                        ldv_settings.fixed_length = 0;
                        ldv_settings.fixed_length_boundaries = 1;
                        ldv_settings.peak_boundaries = 0;
                    case 'Peak to Peak'
                        ldv_settings.fixed_length = 0;
                        ldv_settings.peak_boundaries = 1;
                        ldv_settings.fixed_length_boundaries = 0;
                end       
                
            case 'peak_to_peak_filter_method'
                str = get(options_panel_children(i), 'String');
                val = get(options_panel_children(i), 'Value');  
                switch str{val}
                    case 'Uniform Filter'
                        ldv_settings.uniform_filter = 1;
                        ldv_settings.LC_filter = 0;
                    case 'LC Filter'
                        ldv_settings.uniform_filter = 0;
                        ldv_settings.LC_filter = 1;
                end
            case 'num_samples_from_peak_to_peak'
                ldv_settings.num_samples_from_peak_to_peak = str2num(get(options_panel_children(i), 'String'));
            case 'before_primary_peak_segment_length'
                ldv_settings.before_primary_peak_segment_length = str2num(get(options_panel_children(i),'String'));                
            case 'after_primary_peak_segment_length'
                ldv_settings.after_primary_peak_segment_length = str2num(get(options_panel_children(i),'String'));
            case 'before_secondary_peak_segment_length'
                ldv_settings.before_secondary_peak_segment_length = str2num(get(options_panel_children(i),'String'));
            case 'after_secondary_peak_segment_length'
                ldv_settings.after_secondary_peak_segment_length = str2num(get(options_panel_children(i),'String'));
        end
    end
    %--------------------------------------------------------------
    % --------------------- Plot Options---------------------
    %--------------------------------------------------------------      
    
    % Plot Options
    global plot_preprocessing; 
    global plot_peak_detection; 
    global plot_segment_selection;
    global plot_spectrograms;
    global plot_maximum_likeliness;
    global plot_entropy_scores;
    global plot_train_and_test_data;

    global pause_between_plots;
    global undock_plots;
    
    global plot_options_panel;
    options_panel_children = get(plot_options_panel, 'children');

    for i = 1:length(options_panel_children)
        switch get(options_panel_children(i), 'tag')
            case 'plot_preprocessing' 
                 plot_preprocessing = get(options_panel_children(i),'Value');
            case 'plot_peak_detection' 
                 plot_peak_detection = get(options_panel_children(i),'Value');
            case 'plot_segment_selection' 
                 plot_segment_selection = get(options_panel_children(i),'Value');                
            case 'plot_spectrograms' 
                 plot_spectrograms = get(options_panel_children(i),'Value');
            case 'plot_maximum_likeliness'
                 plot_maximum_likeliness = get(options_panel_children(i),'Value');
            case 'plot_entropy_scores' 
                 plot_entropy_scores = get(options_panel_children(i),'Value');                 
            case 'plot_train_and_test_data'
                plot_train_and_test_data = get(options_panel_children(i),'Value');
                
            case 'pause_between_plots'
                 pause_between_plots = get(options_panel_children(i),'Value');
            case 'undock_plots'  
                 undock_plots = get(options_panel_children(i),'Value');    
        end
    end
    
    
    
end

function c = find_child_by_tag(parent, tag)
    children = get(parent, 'children');
    c = 0;
    
    for i = 1:length(children)
        child_tag = get(children(i), 'tag');
        if strcmp(tag, child_tag)
            c = children(i);
            break;
        end
    end

end
    
    


