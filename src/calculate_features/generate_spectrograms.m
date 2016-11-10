%------------------------------------------------------------------------
%                       GENERATE SPECTROGRAMS
%------------------------------------------------------------------------
function subjects = generate_spectrograms(subjects, spectrograms_plot_handle)
    
    global plot_spectrograms; 
    global pause_between_plots;
    
    global ecg_settings;
    global ldv_settings;
    
    global time_indices;
    global freq_indices;
    global num_bins;
    
    t = [];
    f = [];
    
    fprintf('Calculating spectrograms...\n');
    for i = 1:length(subjects)

        id = subjects(i).id;
        signal_type = subjects(i).signal_type;
       
        switch signal_type
            case 'ecg'
                settings = ecg_settings;
            case 'ldv'
                settings = ldv_settings;
            case 'pcg'
                disp('Unable to calculate spectrograms on pcg signals at this time.');
        end
        
        targetrate = settings.targetrate;
        maxHz = settings.maxHz;
        window = settings.window;
        
    	window_len = settings.window_len;
        step = settings.step;
        overlap = window_len - step;
        
        for j = 1:length(subjects(i).segments)
            if ldv_settings.use_displacement_signal
                subjects(i).segments(j).signal = cumtrapz(subjects(i).segments(j).signal);
            end
            
            % Calculate spectrogram
            [S, f, t] = specgram(subjects(i).segments(j).signal, window_len, targetrate, window, overlap);
            t = t.*1000;
            f = f(find(f <= maxHz));
            S = S(1:length(f),:);       % keep data with freq in interval [0, ecg_maxHz]
            
            S = abs(S);                     % log of the squared magnitude
            S = S.*S;
            S = log(S);
            
            time_indices = t;
            freq_indices = f;
            num_bins = numel(S);
            
            % Reshape the matrix to a vector and save
            subjects(i).segments(j).spectrogram = reshape(S,1,numel(S));
            

            
            % Debug feature extraction
            if plot_spectrograms  
                spectrograms_plot(id, j, subjects(i).segments(j).signal, settings, ...
                    subjects(i).segments(j).spectrogram, spectrograms_plot_handle);
            end
            
            if pause_between_plots && plot_spectrograms
                fprintf('Press enter to continue\n');
                pause
            end
            
            
        end
    end
    

   
end

