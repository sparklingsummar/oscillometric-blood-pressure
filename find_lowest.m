% This function is return the lowest value of a group of data

% How to use:
%   highest = find_lowest(data)
% Argument details:
%   highest: the lowest value
%   Number: the "Number-th" value is lowest
%   data: the orignal data

function [lowest, Number] = find_lowest(data)

lowest = data(1);
Number = 1;

for i = 2:length(data)
    if lowest > data(i)
        lowest = data(i);
        Number = i;
    end
end

end

