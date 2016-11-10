%------------------------------------------------------------------------
%                       SET HIGH ENTROPY SPECTROGRAMS
%------------------------------------------------------------------------
function subjects = set_high_entropy_spectrograms(subjects)
   
    global num_bins;
    global ldv_settings;
    
    fprintf('Setting high entropy spectrogram...\n');
    
    % Put spectrogram values in the selected bins
    for i = 1:length(subjects)
        for j = 1:length(subjects(i).segments)
            high_entropy_spectrogram = zeros(1, num_bins);
            
            for k = 1:num_bins
                if ldv_settings.static_bin_selection
                    if subjects(i).selected_bins(k) == 1
                        high_entropy_spectrogram(k) = subjects(i).segments(j).spectrogram(k);
                    end
                else    %---Dynamic Bin Selection---%
                    if subjects(i).segments(j).selected_bins(k) == 1
                        high_entropy_spectrogram(k) = subjects(i).segments(j).spectrogram(k);
                    end
                end
            end
            
            subjects(i).segments(j).high_entropy_spectrogram = high_entropy_spectrogram;
        end
    end

end

