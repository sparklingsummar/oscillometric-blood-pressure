% This program is for oscillometric blood pressure measurement
% This is a fianl project for a Master sutdent in collecge of enginnering

close all
clear all

% Load recorded sample 'sample.dat'
% sample in report: 15
sample = load('15 120-80.dat');
% Only the second group data will be used
sample = sample(:,3);

% Global Variables
% This part is to prsent all the Global varibales, which will be used in
% functions
% Those varibales present here in order to change easily
% Users might not need to change those varibales!

% Polynomial degree for turning plot into curve (used in function 'Heatbeat_change')
global polyfit_degree
polyfit_degree = 6;

% test set 1 is on, 0 is off
global test_set
test_set = 1;

% filter coffients
% used in filter_sample, Heatbeat_change, 
global N
N = 8000;

% best 0.88
global systolic_constant
systolic_constant = 0.88;

% change y number into mmHg
for i = 1:length(sample)
    sample(i) = change_value(sample(i));
end


if test_set == 1
   figure
   plot(sample);
   title('Original Signals');
   xlabel('Time (ms)');
   ylabel('Pressure (mmHg)');
end

% Divided this sample into heartbeat data and pressure data
[Heartbeat, Pressure] = filter_sample(sample);

% Change Heartbeat signal into a curve
Heart_wave = Heartbeat_change(Heartbeat);

% Caculate systolic and diastolic blood's time
[systolic_time, diastolic_time] = calculate_pressure_time(Heart_wave,Heartbeat);

% Caculate systolic and diastolic blood's pressure
[systolic_pressure, diastolic_pressure] = calculate_pressure(sample, systolic_time, diastolic_time);

