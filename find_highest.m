% This function is return the biggest value of a group of data

% How to use:
%   highest = find_highest(data)
% Argument details:
%   highest: the biggest value
%   Number: the "Number-th" value is biggest
%   data: the orignal data

function [highest, Number] = find_highest(data)

highest = data(1);
Number = 1;

for i = 2:length(data)
    if highest < data(i)
        highest = data(i);
        Number = i;
    end
end

end

