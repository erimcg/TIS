%------------------------------------------------------------------------
%                       SELECT SEGMENTS
%------------------------------------------------------------------------
function subjects = select_segments(subjects, phase, segment_selection_plot_handle)

    global plot_segment_selection;
    global pause_between_plots;
    global num_bins;

    global ecg_settings;
    global ldv_settings;
    global failure_to_enroll_in_training;
    global failure_to_enroll_in_testing;

    fprintf('Selecting samples...\n');

    modality = subjects(1).signal_type;

    switch modality
        case 'ecg'
            settings = ecg_settings;
        case 'ldv'
            settings = ldv_settings;
        case 'pcg'
            disp('Unable to segment pcg signals at this time.');
    end

     switch phase
        case 'train'
            num_segments_needed = settings.num_segments_per_training_subject;
            failure_to_enroll_in_training = 0;
        case 'test'
            num_segments_needed = settings.num_segments_per_test_subject;
            failure_to_enroll_in_testing = 0;
     end

    mode = settings.segment_selection_mode;

    for i = 1:length(subjects)
        num_segments = subjects(i).num_segments;

        if ((strcmp(settings.segment_selection_mode, 'Random') == 1) || ...
                (strcmp(settings.segment_selection_mode, 'Manual') == 1))
            perm_index = randperm(num_segments);
        end

        num_segments_selected = 0;
        segments_visited = 0;
        selected_segments = zeros(1,num_segments);

        %%%%%%%%%%calculate_sum_of_differences(subjects)

        while ((num_segments_selected < num_segments_needed) && (segments_visited < num_segments))
            segments_visited = segments_visited + 1;

            switch mode
                case 'Closest To Mean'
                    % use difference_array to pick next index.
                    % create array of differences
                    difference_array = [];
                    for j = 1:length(subjects(i).segments)
                        difference_array(j) = subjects(i).segments(j).difference;
                    end

                    % now sorts the array
                    % [i,j] = sort(a,2) where a is the original array and i is
                    % the sorted array and j is the array where each element
                    % holds the original index number of each element in the sorted array
                    [sorted_ascending_order, original_indexes] = sort(difference_array, 2);

                    % original_indexes array is ordered according to the sorted
                    % difference array so the first element in the
                    % original_indexes array is the index of the smallest
                    % element in the difference array
                    index = original_indexes(segments_visited);

                case 'Random'
                    index = perm_index(segments_visited);
                case 'From Beginning'
                    index = segments_visited;
                case 'Manual'
                    index = segments_visited;
            end

            is_manual = strcmp(mode, 'Manual');

            if (is_manual || plot_segment_selection)
                choice = segment_selection_plot(is_manual, ...
                    subjects(i).id, index, num_segments_selected, num_segments_needed, ...
                    selected_segments, subjects(i).segments(index).signal, segment_selection_plot_handle, subjects(i).segments(index).spectrogram, subjects(i).mean);

                if (strcmp(choice, 'No') == 1)
                    continue;
                elseif (strcmp(choice, 'Yes') == 1)
                    index = segments_visited;
                elseif (strcmp(choice, 'Select Randomly') == 1)
                    mode = 'Random';
                    continue;
                end
            end

            selected_segments(index) = 1;
            %selects the segment that has the least "difference"
            subjects(i).segments(index).selected = 1;
            num_segments_selected = num_segments_selected + 1;

            if plot_segment_selection && pause_between_plots
                fprintf('Press enter to continue\n');
                pause
            end
        end

        if num_segments_selected < num_segments_needed
            switch phase
                case 'train'
                    failure_to_enroll_in_training = failure_to_enroll_in_training + 1;
                case 'test'
                    failure_to_enroll_in_testing = failure_to_enroll_in_testing + 1;
            end

            for j = 1:subjects(i).num_segments
                subjects(i).segments(j).selected = 0;
            end
        end

    end

    for i = 1:length(subjects)
        selected_segments = [];
        num_selected_segments = 0;
        for j = 1:length(subjects(i).segments)
            if subjects(i).segments(j).selected == 1
                num_selected_segments = num_selected_segments + 1;
                selected_segments(num_selected_segments).signal = subjects(i).segments(j).signal;
                selected_segments(num_selected_segments).spectrogram = subjects(i).segments(j).spectrogram;
                selected_segments(num_selected_segments).diff_matrix = subjects(i).segments(j).diff_matrix;
            end
        end

        subjects(i).segments = selected_segments;
    end

end

% END OF FILE -------------------------------------------------------------
