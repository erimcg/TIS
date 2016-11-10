%------------------------------------------------------------------------
%                       CONSOLIDATE SEGMENTS
%------------------------------------------------------------------------
function subjects = consolidate_segments(samples)
    subjects = {};
    subject_ids = [];
    
    fprintf('Consolidating segments...\n');
    for i = 1:length(samples)
        subject_ids = [subject_ids samples(i).id];
    end
    
    unique_ids = unique(subject_ids);
    
    for i = 1:length(unique_ids)
        id = unique_ids(i);
        
        hits = arrayfun(@(x) x.id == id, samples);
        
        indices = 1:length(samples);
        indices = indices(hits);
        
        subjects(i).id = id;
        subjects(i).segments = {};
        subjects(i).signal_type = samples(indices(1)).signal_type;
        
                
        for j = 1:length(indices)          
            for k = 1:length(samples(indices(j)).segments)
                subjects(i).segments(end + 1).signal = samples(indices(j)).segments(k).signal;
            end
        end
        
        subjects(i).num_segments = length(subjects(i).segments);
    end
end

