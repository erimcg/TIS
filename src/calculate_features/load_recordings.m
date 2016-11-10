%------------------------------------------------------------------------
%                       LOAD RECORDINGS
%------------------------------------------------------------------------

% load_recordings(signal_type, selected_trials) loads the recordings of the
% type specified by signal_type for all trials specified by
% selected_trials. The types specified by signal_type are 'ecg', 'ldv' or
% 'pcg'.  selected_trials is a 2-D array of size [2,12].  If
% selected_trial(j) = 1 then the appropriate recording from trial j is read.

function samples = load_recordings(signal_type, selected_trials, dir_name, file_layout, delineator)
    
    samples = [];
    m = 0;
    
    dir_listing = dir(dir_name);
    num_subjects = length(dir_listing) - 2;
    
    for i = 1:num_subjects

        assert(dir_listing(i+2).isdir, 'Can not open subject directory');
        subject_id = dir_listing(i+2).name;

        % get subject directory object
        subject_dir_listing = dir(fullfile(dir_name, subject_id));
        
        assert(subject_dir_listing(3).isdir, 'Can not open session directory');
        session_date = subject_dir_listing(3).name;
        
        for k = 1:12
            if selected_trials(k) ~= 1
                continue;
            end
            
            % Trial k is selected.  Search for matlab file then csv file.
            trial_name = strcat('trial', num2str(k));
            
            matlab_file_name = strcat(signal_type, '_', trial_name, '.mat');
            matlab_file_path = fullfile(dir_name, subject_id, session_date, matlab_file_name);
            
            csv_file_name = strcat(trial_name, '.csv');
            csv_file_path = fullfile(dir_name, subject_id, session_date, csv_file_name);
            
            no_matlab_file = exist(matlab_file_path) ~= 2;
            no_csv_file = exist(csv_file_path) ~= 2;
            
            if no_matlab_file && no_csv_file
                fprintf('%s does not exist\n', csv_file_path);
                continue;
                
            elseif no_matlab_file
                fprintf('Reading: %s...\n', csv_file_path);
                
                if delineator.tab == 1
                        data = dlmread(csv_file_path, '\t', 0, 1);
                else
                        data = dlmread(csv_file_path, ',', 0, 1);
                end
                
                switch signal_type
                    case 'ecg'
                        signal = data(:, file_layout.ecg_col)';
                    case 'ldv'
                        signal = data(:, file_layout.ldv_col)';
                    case 'pcg'
                        signal = data(:, file_layout.pcg_col)';
                end
                
                id = str2num(subject_id);
                
                fprintf('Saving: %s...\n', matlab_file_path);
                save(matlab_file_path, 'id', 'signal_type', 'signal');
                
                m = m + 1;
                              
                samples(m).id = id;
                samples(m).signal_type = signal_type;
                samples(m).signal = signal;
              
            else
                S = load(matlab_file_path);
                
                m = m + 1;
                
                fprintf('Loading: %s...\n', matlab_file_path);
                samples(m).id = S.id;
                samples(m).signal_type = S.signal_type;
                samples(m).signal = S.signal;
            end
        end
    end   
end

% END OF FILE


