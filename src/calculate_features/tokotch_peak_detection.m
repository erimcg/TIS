function return_value = tokotch_peak_detection(signal, tally_window_interval, window_minimum_size, window_maximum_size, window_size_increment)
    %function returns an array where 0's are general data points, 1's are
    %primary maximums and 2's are secondary maximums.

    %debug area------------------------------------------------------------
    %dbstop in tokotch_peak_detection
    %uncomment above line to debug
    %end of debug area-----------------------------------------------------

    %loading/file caching for speed increase-------------------------------
   
    global subject_model_dir;
    
    %snag the unique signal identifier for this signal
    unique_signal_identifier = get_unique_signal_id(signal);
    
    %on the root directory, the file is called peaks_file.mat.
    peaks_path = fullfile(subject_model_dir, 'peaks_file.mat');
    
    if exist(peaks_path) ~= 2
        %if the file doesn't exist, then 
        fprintf('No peak file found Running Peak Detection alg.\n');
        
        %run the algorithm
        return_value = calculate_peaks(signal, tally_window_interval, window_minimum_size, window_maximum_size, window_size_increment);
        
        %our save struct is of the form:
        %[ unique_signal_id_1, peaks(0), peaks(1), ... peaks(last)
        %  unique_signal_id_2, peaks(0), peaks(1), ... peaks(last)
        %  .
        %  .
        %  .
        %  unique_signal_id_last, peaks(0), peaks(1), ... peaks(last) ]
        
        %since we don't have a struct for saving, create it.
        %cat(2, ...) concatenates horizontally, so we create a row vector.
        peaks_save_array = cat(2, unique_signal_identifier, return_value);
        
        %and save it as our variable in our struct.
        save(peaks_path, 'peaks_save_array');
        return;
    else
        %if the file exists, then load it
        peak_file = load(peaks_path);
        
        %we have to extract the matrix out of the file struct to use it
        peaks_save_array = peak_file.peaks_save_array;
        
        %we search through the first column of our matrix for the ID
        %of this signal to see if we've got a saved peaks array for it.
        found = find(peaks_save_array == unique_signal_identifier, 1);
        
        if(isempty(found))
            %if we didn't find our ID in there,
            fprintf('Unique ID not found. Running Peak Detection alg.\n');
            
            %run the alg and save the value.
            return_value = calculate_peaks(signal, tally_window_interval, window_minimum_size, window_maximum_size, window_size_increment);
            
            %we also want to create a new entry to save, so make it
            new_entry = cat(2, unique_signal_identifier, return_value);
            
            %we use a third party concatenation method to vertically
            %concatenate and pad any extra space with zeroes
            %so that matlab doesn't have a fit about mismatched dimensions.
            peaks_save_array = supervertcat(peaks_save_array, new_entry);
            
            %save it!
            save(peaks_path, 'peaks_save_array');
            return;
        else
            %if we did find our ID in there,
            fprintf('Reading stored peaks.\n');
            
            %get out the row that has our ID
            row_vector = peaks_save_array(found, :);
            
            %and return the peaks_array (without our ID at the front).
            return_value = row_vector(2:numel(row_vector));
            return;
        end
    end
    %end of loading/file caching for speed increase------------------------
end

function C = supervertcat(varargin)
    %third party courtesy of Bruno Luong of mathworks forums
    %concatenates arguements vertically and pads extra space with zeroes
    %to prevent dimension mismatches during concatenation.
    ncol = cellfun('size',varargin,2);
    maxcol = max(ncol);
    for k = 1:nargin
        if ncol(k) < maxcol
            varargin{k}(end,maxcol) = 0;
        end
    end
    C = cat(1, varargin{:});
end

function return_peaks = calculate_peaks(signal, tally_window_interval, window_minimum_size, window_maximum_size, window_size_increment)
    %start of algorithm
    %firstly, find the ideal window size
    ideal_window_size = find_ideal_window_size(signal, window_minimum_size, window_maximum_size, window_size_increment, tally_window_interval);
    %then find the max array of the tallied array of that window size.
    tally_array = get_tallied_array_for_window_size(signal, ideal_window_size, tally_window_interval);
    max_array = filter_tallied_array(tally_array, ideal_window_size, tally_window_interval);
    %max_array is an array with 1's at the primary peaks, now we need to do
    %secondary peaks by peak detection.  First, partition the signal into
    %primary peaks and non-primary peaks.
    partition_array = partition_array_into_primary_and_not_primary(signal, max_array, round(ideal_window_size / 20));
    %then find those secondary peaks.
    all_peaks = find_secondary_peaks(signal, partition_array, max_array);
    return_peaks = all_peaks;
end

function signal_id = get_unique_signal_id(signal)
    %this function returns a "unique" signal id for a given signal.
    %This allows us to not worry about having to match signal types plus 
    %subject ID's plus other trial number as a unique identifier for
    %the signal.  
    
    %each signal_id is a 20 digit number.
    %the first 5 digits come from the first 5 digits of the first element
    %of the signal  digits 6-10 from the second element, digits 11-15 from
    %the third element and digits 16-20 from the fourth element.
    
    %we take each raw number and drop the minus sign, do 5 digit chopping
    %(rounding), multiply it to ensure that matlab's num2str method treats
    %all 5 digits as significant, and then remove all decimal places.  This
    %gives us four strings of five digits each that are concatenated for
    %the id.
    id_1 = strrep(num2str(chop(abs(signal(1)),5)*100000), '.', '');
    id_2 = strrep(num2str(chop(abs(signal(2)),5)*100000), '.', '');
    id_3 = strrep(num2str(chop(abs(signal(3)),5)*100000), '.', '');
    id_4 = strrep(num2str(chop(abs(signal(4)),5)*100000), '.', '');
    id_cat = strcat(id_1, id_2, id_3, id_4);
    signal_id = str2num(id_cat);
end

function tallied_array = get_tallied_array_for_window_size(signal, window_size, tally_window_interval)
    %function get_tallied_array_for_window_size returns an array of
    %the same size of signal for a given window size that starts as
    %an array of zeroes and is incremented for each maxmimum
    %in a given window of size window_size as it is offset through
    %the signal by the value of window_interval.
    %window size has to be decremented because matlab loop conditions are
    %inclusive by default.
    tallied_array = zeros(size(signal));
    for current_array_start_index = [1:tally_window_interval:size(signal,2)-(window_size-1)]
        current_max_range = -100000000; %todo, change this to negative infinity or equivalent
        current_index_of_max_range = -1;
        for current_array_current_index = [current_array_start_index:1:current_array_start_index+(window_size-1)]
           if(signal(current_array_current_index) > current_max_range)
               current_max_range = signal(current_array_current_index);
               current_index_of_max_range = current_array_current_index;
           end
        end
        tallied_array(current_index_of_max_range) = tallied_array(current_index_of_max_range) + 1;
    end
end

function max_array = filter_tallied_array(tallied_array, window_size, tally_window_interval)
    %function filter_tallied_array returns an array with 1's in the
    %maximum's of each window size, determined by a threshold cutoff filter
    %which is currently set at 75% (or it was determined to be a max of at
    %least 3/4 of the possible windows that it was included in.)
    max_array = zeros(size(tallied_array));
    for current_index = [1:1:size(tallied_array,2)]
        if(tallied_array(current_index) > (3/4)*((window_size)/tally_window_interval))
            max_array(current_index) = 1;
        end
    end
end

function std_dev = get_standard_deviation_between_peaks(max_array)
    %returns the standard deviation of the distance between peaks of the
    %max_array.
    nonzeros = find(max_array);
    distance_array = zeros(size(nonzeros)-[0,1]);
    for current_index = [1:1:size(distance_array,2)]
       distance_array(current_index) = nonzeros(current_index+1) - nonzeros(current_index);
    end
    std_dev = std(distance_array);
end

function window_size = find_ideal_window_size(signal, minimum_window_size, maximum_window_size, window_size_increment, tally_window_interval)
    %function find_ideal_window_size finds the ideal
    %window size by minimizing the standard deviation of the distance
    %between the peaks given by each max_array for each window size.
    minimum_deviation_window_size = 100000000000000; %todo, change this to positive infinity
    minimum_standard_deviation_between_peaks = 100000000000000; %todo, change this to positive infinity
    for current_window_size = [minimum_window_size: window_size_increment: maximum_window_size]
        tallied_array = get_tallied_array_for_window_size(signal, current_window_size, tally_window_interval);
        max_array = filter_tallied_array(tallied_array, current_window_size, tally_window_interval);
        std_dev = get_standard_deviation_between_peaks(max_array);
        if(std_dev <= minimum_standard_deviation_between_peaks)
            minimum_standard_deviation_between_peaks = std_dev;
            minimum_deviation_window_size = current_window_size;
        end
    end
    window_size = minimum_deviation_window_size;
end

function peak_width_left = get_left_peak_width(signal, peak_index, window_size)
    %returns the "length" that the peak (on average) decreass to the left.
    %it loops until two window lengths in a row return a positive average
    %change, then returns the distance from the peak_index to the first
    %window length's left.
    right_index = peak_index;
    right_point = signal(right_index);
    left_index = right_index - window_size;
    if(left_index >= 1)
        left_point = signal(left_index);
        number_of_average_increasing_windows = 0;
    else
        %to avoid out of bounds errors
        left_index = 1;
        left_point = singal(left_index);
        number_of_average_increasing_windows = 2;
    end

    while(number_of_average_increasing_windows < 2)
        if(left_point < right_point)
            number_of_average_increasing_windows = 0;
        else
            number_of_average_increasing_windows = number_of_average_increasing_windows + 1;
        end
        right_index = left_index;
        right_point = signal(right_index);
        left_index = left_index - window_size;
        if(left_index >= 1)
            left_point = signal(left_index);
        else
            %to avoid out of bounds errors
            left_index = 1;
            left_point = signal(left_index);
            number_of_average_increasing_windows = 2;
        end
   end
   peak_width_left = peak_index-(right_index + window_size * 2);
end

function peak_width_right = get_right_peak_width(signal, peak_index, window_size)
    %same as above, but to the right.
   left_index = peak_index;
   left_point = signal(left_index);
   right_index = peak_index + window_size;
   if(right_index <= size(signal, 2))
       right_point = signal(right_index);
       number_of_average_increasing_windows = 0;
   else
       right_index = size(signal,2);
       right_point = singal(right_index);
       number_of_average_increasing_windows = 2;
   end
   while(number_of_average_increasing_windows < 2)
       if(right_point < left_point)
           number_of_average_increasing_windows = 0;
       else
           number_of_average_increasing_windows = number_of_average_increasing_windows + 1;
       end
       left_index = right_index;
       left_point = signal(left_index);
       right_index = right_index + window_size;
       if(right_index <= size(signal,2))
           right_point = signal(right_index);
       else
           right_index = size(signal,2);
           right_point = signal(right_index);
           number_of_average_increasing_windows = 2;
       end
   end
   peak_width_right = (left_index - window_size * 2) - peak_index;
end

function partitioned_array = partition_array_into_primary_and_not_primary(signal, max_array, sub_window_size)
    %returns partitioned_array which has a 1 for all elements in the signal
    %that belong to the maximum peaks, as supplied by max_array.
    %Otherwise, returns 0 in that location.
    partitioned_array = max_array;
    found = find(max_array);
    for current_peak_index_iterator = [1:1:size(found,2)]
        current_peak_index = found(current_peak_index_iterator);
        peak_width_left = get_left_peak_width(signal, current_peak_index, sub_window_size);
        peak_width_right = get_right_peak_width(signal, current_peak_index, sub_window_size);
        for i = [current_peak_index - peak_width_left:1:current_peak_index + peak_width_right]
            partitioned_array(i) = 1;
        end
    end
end

function all_peaks = find_secondary_peaks(signal, partitioned_array, max_array)
    %function returns peaks array where 1's represent primary peaks, 0's
    %represent not peaks, and 2's represent secondary peaks.
    %it does this by finding the maximum for every grouping of
    %zeros in partitioned_array and changing the respective max_array's
    %value to 2 at that same index.
    all_peaks = max_array;
    previous_max_index = -1;
    previous_max = -10000000;
    %partitioned array comes in of a form silmilar to:
    %1111111000000000000000011111111111111110000000000000000001111111111111
    for index_iterator = [1:1:size(signal,2)];
        if(partitioned_array(index_iterator) > 0)
            if(previous_max_index ~= -1)
                all_peaks(previous_max_index) = 2;
                previous_max_index = -1;
                previous_max = -10000000;
            end
        else
            if(signal(index_iterator) > previous_max)
                previous_max = signal(index_iterator);
                previous_max_index = index_iterator;
            end
        end
    end
    %run once more at the end in case we end on a secondary peak.
    if(previous_max_index ~= -1)
        all_peaks(previous_max_index) = 2;
    end
    %we don't want a secondary peak appearing before a primary peak, so we
    %get rid of all secondary peaks before the first primary peak.
    r_peaks = find(all_peaks == 1);
    s_peaks = find(all_peaks == 2);
    first_r_peak = r_peaks(1);
    first_s_peak = s_peaks(1);
    if(first_s_peak < first_r_peak)
        all_peaks(first_s_peak) = 0;
    end
end
