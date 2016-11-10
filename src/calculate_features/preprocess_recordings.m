
%------------------------------------------------------------------------
%                       PREPROCESS RECORDINGS
%------------------------------------------------------------------------
function recordings = preprocess_recordings(recordings, phase, preprocessing_plot_handle)
    
    if isempty(recordings)
        fprintf('No recordings to preprocess\n');
        return;
    end
    
    switch recordings(1).signal_type
        case 'ecg'
            recordings = preprocess_ecg_recordings(recordings, phase, preprocessing_plot_handle);
        case 'ldv'
            recordings = preprocess_ldv_recordings(recordings, phase, preprocessing_plot_handle);
        case 'pcg'
            fprintf('Unable to preprocess pcg signals at this time.\n');
            return;
    end
    
end

function recordings = preprocess_ecg_recordings(recordings, phase, preprocessing_plot_handle)
        
    global training_samplerate;
    global testing_samplerate;
    global plot_preprocessing;
    global pause_between_plots;

    global ecg_settings;

    fprintf('Preprocessing ecg recordings...\n');

    for i = 1:length(recordings)       
        id = recordings(i).id;
        n = 0;
        clear plots;
        
        if plot_preprocessing
            n = n + 1;
            plots(n).signal = recordings(i).signal;
            plots(n).title = 'Original Signal';
        end
        
        switch phase
            case 'train'
                if  training_samplerate ~= ecg_settings.targetrate
                    decimate_factor = ceil(training_samplerate/ecg_settings.targetrate);
                    if plot_preprocessing
                        n = n + 1;
                        plots(n).signal = recordings(i).signal;
                        plots(n).title = 'Decimated Signal';
                    end
                end
            case 'test'
                if  testing_samplerate ~= ecg_settings.targetrate
 
                    if plot_preprocessing
                        n = n + 1;
                        plots(n).signal = recordings(i).signal;
                        plots(n).title = 'Decimated Signal';
                    end
                end
        end
        
        if ecg_settings.apply_trim_filter
            fresult = fft(recordings(i).signal);
            fresult(1 : round(length(fresult)*1/ecg_settings.targetrate)) = 0;
            fresult(end - round(length(fresult)*1/ecg_settings.targetrate) : end) = 0;
            recordings(i).signal = real(ifft(fresult));          
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'High Pass Filtered Signal';             
            end
        end
        
        if ecg_settings.apply_notch_filter
            % Filter out 172.8 Hz using notch filter
            %fprintf('Applying notch filter...\n');

            wo = 172.8/(ecg_settings.targetrate/2);  
            bw = 13/(ecg_settings.targetrate/2);
            [b,a] = iirnotch(wo,bw,7);
            recordings(i).signal = filter(b,a,recordings(i).signal);
            
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'Notch Filtered Signal';              
            end
        end  
        
        if plot_preprocessing
            multiplot(plots, preprocessing_plot_handle);

            if pause_between_plots
                fprintf('Press enter to continue\n');
                pause
            end
        end
        
    end
end

function recordings = preprocess_ldv_recordings(recordings, phase, preprocessing_plot_handle)
    global training_samplerate;
    global testing_samplerate;
    global plot_preprocessing;
    global pause_between_plots;

    global ldv_settings;
    
    fprintf('Preprocessing ldv recordings...\n');

    for i = 1:length(recordings)
        recordings(i).orig = recordings(i).signal;
        
        id = recordings(i).id;
        n = 0;
        clear plots;
        
        if plot_preprocessing
            n = n + 1;
            plots(n).signal = recordings(i).signal;
            plots(n).title = 'Original Signal';
        end
        
        switch phase
            case 'train'
                samplerate = training_samplerate;
            case 'test'
                samplerate = testing_samplerate;
        end
        
        if  samplerate > ldv_settings.targetrate
            
            %new_signal = downsample(recordings(i).signal, 10);
            %new_signal = resample(recordings(i).signal, ldv_settings.targetrate, samplerate);
            decimate_factor = ceil(samplerate/ldv_settings.targetrate);

            if ldv_settings.chebyshev_filter
                recordings(i).signal = decimate(recordings(i).signal, decimate_factor);
            else
                %%% --- TODO: Create Median Filter Here --- %%%
                
                orig_num_samples = length(recordings(i).signal);
                num_secs = orig_num_samples/samplerate;
                new_num_samples = ceil(num_secs * ldv_settings.targetrate);
                
                new_signal = zeros(1, new_num_samples);
                
                step_size = samplerate/ldv_settings.targetrate;
                step_count = 1;
                step_total = 0;
                
                upper_index = 1;
                
                while (1)
                    lower_index = upper_index;
                    step_total = step_total + step_size;
                    upper_index = round(step_total);
                    if (upper_index > orig_num_samples)
                        break;
                    end
                    new_signal(step_count) = median(recordings(i).signal(lower_index:upper_index));
                    step_count = step_count + 1;
                end
                recordings(i).signal = new_signal;
            end
            
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'Decimated Signal';
            end
        end
        
        ldv_settings.apply_high_pass_filter;
        if ldv_settings.apply_high_pass_filter
            fresult = fft(recordings(i).signal);
            fresult(1 : round(length(fresult)*1/ldv_settings.targetrate)) = 0;
            fresult(end - round(length(fresult)*1/ldv_settings.targetrate) : end) = 0;
            recordings(i).signal = real(ifft(fresult));
            
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'High Pass Filtered Signal';
            end
        end
        
        ldv_settings.apply_trim_filter;
        if ldv_settings.apply_trim_filter
            fresult = recordings(i).signal;
            fresult (1 : ldv_settings.targetrate) = 0;
            fresult(end - ldv_settings.targetrate : end) = 0;
            recordings(i).signal = fresult;
            
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'Trim Filter Signal';
            end
        end
        
        ldv_settings.remove_dropouts;
        if ldv_settings.remove_dropouts
            recordings(i).signal = func_despike_phasespace3d(recordings(i).signal, 0, 2);
            
            if plot_preprocessing
                n = n + 1;
                plots(n).signal = recordings(i).signal;
                plots(n).title = 'Despeckled Signal';
            end
        end
        
        if plot_preprocessing
            multiplot(plots, preprocessing_plot_handle);
            
            if pause_between_plots
                fprintf('Press enter to continue\n');
                pause
            end
        end
    end
 
end


% END OF FILE *************************************************************

