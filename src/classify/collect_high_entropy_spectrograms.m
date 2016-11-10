%------------------------------------------------------------------------
%                       COLLECT HIGH ENTROPY SPECTROGRAMS
%------------------------------------------------------------------------
function [x y] = collect_high_entropy_spectrograms(subjects)
    global num_bins;
    
    x = [];
    y = [];

    num_features = num_bins;

    for i = 1:length(subjects)
        for j = 1:length(subjects(i).segments)  
            y = [y subjects(i).id];
            x = [x subjects(i).segments(j).high_entropy_spectrogram];
        end
    end
   
    x = reshape(x, num_features, length(y))';
    y = y';
    
end

