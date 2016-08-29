% This function is find highest value for each peaks
% This function can only be used in 'find_peak'

% assuming heart_applitude is the abs value between Q and R (in ECG)

% How to use:
%   heart_applitude = find_heart_amplitude(peak_time,signal)
% Argument details:
%   heart_applitude: how strong is this beat
%   peak_time: time to reach peak
%   signal: the whole orignal signal

function [heart_applitude, Q_point] = find_heart_amplitude(peak_time,signal)

for i = 100:100000
    % if the perivous value is greater than next value, this is the Q piont
    if signal(peak_time-i-1) > signal(peak_time-i) 
        heart_applitude = signal(peak_time) - signal(peak_time-i);
        Q_point = peak_time-i;
        break;
    end
end