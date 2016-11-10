%------------------------------------------------------------------------
%                       SEGMENT RECORDINGS
%------------------------------------------------------------------------
function recordings = segment_recordings(recordings, peak_detection_plot_handle)
 
    global plot_peak_detection;
    global pause_between_plots;

    global ecg_settings;
    global ldv_settings;
    fprintf('Peaks detected \n')
    fprintf('Segmenting recordings...\n')
    
    for i = 1:length(recordings)        
        signal = recordings(i).signal;
        id = recordings(i).id;
        signal_type = recordings(i).signal_type;
        
       
        switch signal_type
            case 'ecg'
                settings = ecg_settings;
            case 'ldv'
                settings = ldv_settings;
            case 'pcg'
                disp('Unable to segment pcg signals at this time.');
                return;
        end

        before_primary_peak_segment_length = settings.before_primary_peak_segment_length;
        after_primary_peak_segment_length = settings.after_primary_peak_segment_length;
        before_secondary_peak_segment_length = settings.before_secondary_peak_segment_length;
        after_secondary_peak_segment_length = settings.after_secondary_peak_segment_length;
        
        num_segments_per_beat = settings.num_segments_per_beat;        
        samples_wanted_between_peaks = settings.num_samples_from_peak_to_peak;
        
        

        % Find R-peaks - Note: detect_peaks skips the first and last beats!

        %%%%%%%%%%%%%%%ADD ANOTHER PARAMETER THAT HOLDS THE SIGNAL TYPE TO
        %%%%%%%%%%%%%%%BE SENT TO DETECT_PEAKS.M
        %fprintf('detecting peaks\n'); moved from detect_peaks.m to here so that it only gets printed once
        r_peaks = detect_peaks(signal, id, plot_peak_detection, peak_detection_plot_handle, signal_type);
        %r_peaks is actually all peaks, including secondary peaks, which
        %are denoted with a 2 instead of a 1.
        
        if pause_between_plots && plot_peak_detection
            fprintf('Press enter to continue\n');
            pause
        end
        r_peaks_loc = find(r_peaks == 1);
        s_peaks_loc = find(r_peaks == 2);
        recordings(i).r_peaks = r_peaks_loc;
        num_peaks = length(r_peaks_loc);
        
        %fprintf('%d - %d peaks found...\n', id, num_peaks);
        heart_rate = length(find(r_peaks_loc < 60000));
        %fprintf('Heart rate: %d bpm...\n', heart_rate);        
        
        % Calculate segments
        segments = {};
        num_segments = 1;
        if settings.fixed_length
            while(1)
                lower_index = (num_segments - 1) * 1000 + 1;
                upper_index = num_segments*1000;
                if (upper_index > length(signal))
                    break;
                end
                segments(num_segments).signal = signal(lower_index:upper_index);
                num_segments = num_segments + 1;
            end
        elseif settings.fixed_length_boundaries
            for j = 1:num_peaks-1
                if settings.fixed_length_boundaries && (num_segments_per_beat == 1)
                    beat_loc = r_peaks_loc(j)-before_primary_peak_segment_length:1:r_peaks_loc(j)+after_primary_peak_segment_length;
                    if beat_loc(1) < 1 || beat_loc(end) > length(signal)
                        continue;
                    end
                    segments(num_segments).signal = signal(beat_loc);
                    num_segments = num_segments + 1;
                elseif settings.fixed_length_boundaries && (num_segments_per_beat == 2)
                    if(j > length(r_peaks_loc) || j > length(s_peaks_loc))
                        continue;
                    end
                    p_beat_loc = r_peaks_loc(j)-before_primary_peak_segment_length:1:r_peaks_loc(j)+after_primary_peak_segment_length;
                    s_beat_loc = s_peaks_loc(j)-before_secondary_peak_segment_length:1:s_peaks_loc(j)+after_secondary_peak_segment_length;
                    if p_beat_loc(1) < 1 || p_beat_loc(end) > length(signal)
                        continue;
                    elseif s_beat_loc(1) < 1 || s_beat_loc(end) > length(signal)
                        continue;
                    end
                    %we want to match each primary peak with the following secondary peak.
                    p_segment = signal(p_beat_loc);
                    s_segment = signal(s_beat_loc);
                    combined_segment = cat(2, p_segment, s_segment);
                    segments(num_segments).signal = combined_segment;
                    num_segments = num_segments + 1;
                end
                
               
            end
        elseif settings.peak_boundaries
            if settings.uniform_filter
                for j = 1:num_peaks-1
                    if r_peaks_loc(1) < 1 || r_peaks_loc(end) > length(signal)
                        continue;
                    end
                    beat_loc = r_peaks_loc(j):1:r_peaks_loc(j+1); 
                    segments(num_segments).signal = interpft(signal(beat_loc), ldv_settings.num_samples_from_peak_to_peak);
                    num_segments = num_segments + 1;
                end
                %             elseif settings.LC_filter
                %
                %                 original_signal = signal;
                %                 sample_counter = 1;
                %
                %                 if settings.no_filter == 0 && settings.fixed_length_boundaries == 0
                %
                %                     for sample_counter = 1:(num_peaks -1)
                %                         samples_between_peaks = r_peaks_loc(sample_counter+1) - r_peaks_loc(sample_counter);
                %                         sample_difference = samples_wanted_between_peaks - samples_between_peaks;
                %                         difference_rate = samples_between_peaks/samples_wanted_between_peaks;
                %
                %                         upper_bound = r_peaks_loc(sample_counter);
                %                         lower_index = r_peaks_loc(sample_counter);
                %                         upper_index = r_peaks_loc(sample_counter);
                %                         upper_limit = r_peaks_loc(sample_counter+1);
                %
                %                         if sample_difference > 0
                %                             while (1)
                %                                 lower_index = upper_index;
                %                                 upper_bound = upper_bound + difference_rate;
                %                                 upper_index = round(upper_bound);
                %                                 if upper_index == upper_limit
                %                                     break;
                %                                 end
                %                                 altered_signal(sample_counter) = original_signal(upper_index);
                %                             end
                %
                %                         elseif sample_difference < 0
                %                             while (1)
                %                                 lower_index = upper_index;
                %                                 upper_bound = upper_bound + difference_rate;
                %                                 upper_index = round(upper_bound);
                %                                 if upper_index == upper_limit
                %                                     break;
                %                                 end
                %                                 altered_signal(sample_counter) = original_signal(upper_index);
                %                             end
                %                         end
                %                         signal(samples_counter) = altered_signal;
                %                         sample_counter = sample_counter + 1;
                %                     end
                %
                %                     recordings(i).signal = signal(1:sample_counter);
                %                 end
                %             end
            end
        end
        recordings(i).segments = segments;
        recordings(i).num_segments = num_segments;
    end
end

