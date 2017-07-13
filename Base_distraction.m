function [d_off] = Base_distraction(video,d)
    % Removing the base structure - distract the initial frame from current frame 
    % improvment: frame beolvasást itt megoldani
    
    % Reading the initial frame
    
    
    % Distraction
    d_off = minus(d,init_frame);
end