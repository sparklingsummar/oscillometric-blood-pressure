% This program is for oscillometric blood pressure measurement
% This is a fianl project for a Master sutdent in collecge of enginnering

close all
clear all

result = [130,0,80,0; % 1%
          105,0,65,0; %10%
          110,0,60,0; %11%
          110,0,78,0; %12%
          105,0,65,0; %13%
          117,0,80,0; %14%
          120,0,80,0; %15%
          128,0,72,0; %16%
          115,0,75,0; %17%
          117,0,80,0; %18%
          120,0,78,0; %19%
          110,0,70,0; % 2%
          142,0,72,0; %20%
          108,0,72,0; % 3%
          115,0,65,0; % 4%
          120,0,70,0; % 5%
          100,0,60,0; % 6%
          110,0,70,0; % 7%
          110,0,70,0; % 8%
          110,0,60,0; % 9%
          ];
      
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
test_set = 0;

% filter coffients
% used in filter_sample, Heatbeat_change, 
global N
N = 8000;

global systolic_constant
systolic_constant = 0.88;

if test_set == 1
   figure
   plot(sample);
   title('Original Signal');
   xlabel('Time (ms)');
   ylabel('Pressure (mmHg)');
end



mydir='D:\google drive\MASTER\MSC PROJECT\matlab\project\data\sample\';
temp1=dir([mydir,'*.dat']);
number_recorded = 1;
% for polyfit_degree = 4:20
% for systolic_constant = 1:0.01:1.2
            for i = 1:20
                % read data
                filename = [mydir,temp1(i).name];
                sample = 0;
                Heartbeat = 0;
                Heart_wave = 0;
                systolic_time = 0;
                diastolic_time = 0;
                sample=dlmread(filename,'',3);
                sample = sample(:,3);
                
                % change y number into mmHg
                for i1 = 1:length(sample)
                    sample(i1) = change_value(sample(i1));
                end
    
                % Divided this sample into heartbeat data and pressure data
                [Heartbeat, Pressure] = filter_sample(sample);

                % Change Heartbeat signal into a curve
                Heart_wave = Heartbeat_change(Heartbeat);

                % Caculate systolic and diastolic blood's time
                [systolic_time, diastolic_time] = calculate_pressure_time(Heart_wave);

                % Caculate systolic and diastolic blood's pressure
                [result(i,2), result(i,4)] = calculate_pressure(sample, systolic_time, diastolic_time);
            end
            
            % cacluate result_abs
            result_abs = 0;
            for i1 = 1:20
                result_abs = result_abs + (result(i1,2)-result(i1,1))*(result(i1,2)-result(i1,1));
            end
            if  number_recorded == 1
                number_recorded = number_recorded +1;
                result_small = result_abs;
                reslut_final = result;
                polyfit_degree_final = systolic_constant ;
            else
                if result_small > result_abs
                    result_small = result_abs;
                    reslut_final = result;
                    polyfit_degree_final = systolic_constant ;
                end
            end
            systolic_constant
% end
reslut_final
polyfit_degree_final

