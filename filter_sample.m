% This function is to divid a smaple data into two parts: heartbeat data 
% and pressure data

% How to use:
%   [Heartbeat, Pressure] = filter_sample(sample)
% Argument details:
%   Heartbeat: the heartbeat data
%   Pressure: pressure data
%   sample: orignal data

function [Heartbeat, Pressure] = filter_sample(sample)

% heartbeart
% Considering the sampling rate is 1K Hz, and the noise in 50Hz need to be
% removed
% Human's heartbeat might not less than 0.5 Hz (30 times per minute)
global N
Wnlow = 0.5/1000;
Wnhigh = 5/1000;


[b,a] = butter(3, [Wnlow Wnhigh]);
Heartbeat = filter(b,a,sample);


global test_set
if test_set == 1
   figure
   plot(Heartbeat);
   title('Filtered Signals');
   xlabel('Time (ms)');
end

% Remove the very beginning data and final data
% Those cant be the high pressure and low pressure
Heartbeat(1:N) = 0;
Heartbeat(length(Heartbeat)-N/4:length(Heartbeat)) = 0;


if test_set == 1
   figure
   plot(Heartbeat);
   title('Filtered Signals (Remove delay)');
   xlabel('Time (ms)');
end

% Pressure
b = fir1(N,Wnlow);
Pressure = filter(b,1,sample);

end