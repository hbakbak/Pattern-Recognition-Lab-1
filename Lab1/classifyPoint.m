function [class] = classifyPoint(CD,DE,CE)
%PURPOSE: Classifies a point given MED discriminant function output
%   Returns class that a point belongs to for case 2 (3 classes)
if (CD >= 0) && (DE <= 0)
    class = 2; % Class D
elseif (CD <= 0) && (CE >= 0)
    class = 1; % Class C
elseif (CE <= 0) && (DE >= 0)
    class = 3; % Class E
else
    disp('classifyPoint: none of the 3 Class cases were satisfied...')
end

end

