% This function is find highest value for each peaks
% This function can only be used in 'Heatbeat_change'

% How to find each peak?
%   1> find the first peak;
%   2> the next peak happens in the next 0.2~1.2s (the next peak the biggest 
%   value in the from next 200 to 1200 sample)
%       0.2: R to S part (it is possible the following value of the prior 
%            peak is bigger than next peaks' value, and after 0.2s the peak 
%            will be passed)
%       1.2: Human's heartbeat could less than 50 times per minute?
% How to fin the first peak:
%   1> the peaks' value at the beginning is similar (no bloodstream)
%   2> ingore the part I cut off (0 part at the beginning), there will
%   always be at least one heartbeat at the first 1.5 s (1.5s = 1500 samples)

% How to use:
%   A = find_peak(sample)
% Argument details:
%   A: is a dyadic array, (x,y,z), x is the Nth number for R, y is the Nth number for Q, z is its value
%   sample: orignal data

function A = find_peak(sample)

A = [];

% find the frist value isn't 0
for i1 = 1:length(sample)
    if sample(i1) ~= 0;
        break
    end
end

% find first peak
[peak, i_change] = find_highest(sample(i1:i1+1500));

A(1,1) = i1+i_change-1;
A(1,2) = i1;
A(1,3) = peak;

% find the following peaks
% ideally, there won't be length(sample)-th peak
for i2=2:length(sample)
    peak = 0;
    i_change = 0;
    [peak, i_change] = find_highest(sample(A(i2-1,1)+201:A(i2-1,1)+1100));
    A(i2,1) = A(i2-1,1)+i_change+200;
    [A(i2,3),A(i2,2)] = find_heart_amplitude(A(i2,1),sample);
    if (sample(A(i2,1)+1100) == 0 && sample(A(i2,1)+1101) == 0)
        break;
    end
end