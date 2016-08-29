% This function is detemine when systolic and diastolic pressure happen
% Ideally, systolic pressure amplitude would be a constant proportions of
% highest amplitude, as well as diastolic amplitude

% How to use:
%   [systolic_time, diastolic_time] = cacluate_pressure_time(Heart_wave1)
% Argument details:
%   systolic_time: which sample (or when) is the systolic pressure
%   diastolic_time: which sample (or when) is the diastolic pressure
%   Heart_wave1: the replot heart beat signal (after polyval), must be the
%               output of function 'Heatbeat_change'

function [systolic_time, diastolic_time] = calculate_pressure_time(Heart_wave,Heartbeat)


global N
% initialization
systolic_time = 0;
diastolic_time = 0;
% first, find the biggest amplitude
Heart_wave1 = Heart_wave(:,1);
[highestValue, highestNumber] = find_highest(Heart_wave1(round(length(Heart_wave1)*0.35):length(Heart_wave1)*0.75));
highestNumber = highestNumber + round(length(Heart_wave1)*0.35);

% if highestNumber < length(Heart_wave1)*0.35
%     [highestValue, highestNumber] = find_highest(Heart_wave1(round(length(Heart_wave1)*0.35):length(Heart_wave1)));
%     highestNumber = highestNumber + round(length(Heart_wave1)*0.35);
% end
% 
% if highestNumber > length(Heart_wave1)*0.75
%     [highestValue, highestNumber] = find_highest(Heart_wave1(1:length(Heart_wave1)*0.75));
%     highestNumber = highestNumber;
% end


% plot marked highest value
global test_set
if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Marked highest value');
    xlabel('Time (ms)');
    hold on 
    plot(Heart_wave(:,1));
    plot(highestNumber, Heart_wave(highestNumber,1),'r.','markersize',30,'Color',[0 1 0.1])
    legend('Filtered Signals','Regression Curve', 'Highest Point');
    hold off
end

for i = 1:length(Heart_wave)
    peak_group(i,1) = Heart_wave(i,4);
    peak_group(i,2) = Heart_wave(i,5);
    if Heart_wave(i+1,4) == 0
        break
    end
end


% find systolic time
ydiff = Heart_wave(:,2);
ydiff2 = Heart_wave(:,3);
for i1 = 1:highestNumber-N
    if ydiff2(highestNumber - i1) > 0
        systolic_time = highestNumber - i1;
        break;
    end
end
systolic_time1 = systolic_time;

if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Marked highest increasing rate point in curve');
    xlabel('Time (ms)');
    hold on 
    plot(Heart_wave(:,1));
    plot(systolic_time, Heart_wave(systolic_time,1),'r.','markersize',30,'Color',[0 0.5 0.5])
    plot(highestNumber, Heart_wave(highestNumber,1),'r.','markersize',30,'Color',[0 1 0.1])
    legend('Filtered Signals','Regression Curve', 'Highest Increasing Rate Point', 'Highest Point');
    hold off
end

if test_set == 1
    % plot it if test
    figure
    subplot(2,1,1)
    plot(ydiff)
    title('Marked highest increasing rate point in first derivative');
    xlabel('Time (ms)');
    hold on 
    plot(systolic_time, ydiff(systolic_time,1),'r.','markersize',30,'Color',[0 0.5 0.5])
    legend('First Derivative of Regression Curve', 'Highest Increasing Rate Point');
    hold off
    subplot(2,1,2)
    plot(ydiff2)
    title('Marked highest increasing rate point in second derivative');
    xlabel('Time (ms)');
    hold on 
    plot(systolic_time, ydiff2(systolic_time,1),'r.','markersize',30,'Color',[0 0.5 0.5])
    legend('Second Derivative of Regression Curve', 'Highest Increasing Rate Point');
    hold off
end

global systolic_constant
for i2 = 1:systolic_time-N
    if ydiff(systolic_time - i2) < ydiff(systolic_time)*systolic_constant
        systolic_time = systolic_time - i2;
        break;
    end
end
systolic_time2 = systolic_time;

if test_set == 1
    % plot it if test
    figure
    subplot(2,1,1)
    plot(Heartbeat)
    title('Regression Curve');
    xlabel('Time (ms)');
    hold on 
    plot(Heart_wave(:,1));
    plot(systolic_time1, Heart_wave(systolic_time1,1),'r.','markersize',30,'Color',[0.3 0.2 0.8])
    plot(systolic_time2, Heart_wave(systolic_time2,1),'r.','markersize',30,'Color',[0 0.5 0.5])
    plot(highestNumber, Heart_wave(highestNumber,1),'r.','markersize',30,'Color',[0 1 0.1])
    text(systolic_time1-1000, Heart_wave(systolic_time1,1)+0.1,'t2');
    text(systolic_time2-1000, Heart_wave(systolic_time2,1)+0.1,'t3');
    text(highestNumber-1000, Heart_wave(highestNumber,1)+0.1,'t1')
    legend('Filtered Signals','Regression Curve')
    hold off
    subplot(2,1,2)
    plot(ydiff)
    title('First Derivative of Regression Curve');
    xlabel('Time (ms)');
    hold on 
    plot(systolic_time1, ydiff(systolic_time1,1),'r.','markersize',30,'Color',[0.3 0.2 0.8])
    plot(systolic_time2, ydiff(systolic_time2,1),'r.','markersize',30,'Color',[0 0.5 0.5])
    plot(highestNumber, ydiff(highestNumber,1),'r.','markersize',30,'Color',[0 1 0.1])
    text(systolic_time1, ydiff(systolic_time1,1)+0.01/1000,'t2');
    text(systolic_time2, ydiff(systolic_time2,1)+0.01/1000,'t3');
    text(highestNumber, ydiff(highestNumber,1)+0.01/1000,'t1')
    hold off
end

record_line = zeros(4,1);
for i = 1:4
    record_line(i) = i;
end

% find the nearest 4 heart beat
for i = 3:length(peak_group)
    if peak_group(i,1) < systolic_time
        record_line(1) = i-1;
        record_line(2) = i;
    else
        record_line(3) = i;
        record_line(4) = i+1;
        break
    end
end

% compare the difference
for i = 1:3
    differ(i) = peak_group(record_line(i+1),2) / peak_group(record_line(i),2);
end
[differValue, differNumber] = find_highest(differ);
systolic_time = peak_group(record_line(differNumber),1);

if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Systolic Pressure Time');
    xlabel('Time (ms)');
    hold on 
    plot(Heart_wave(:,1));
    plot(peak_group(record_line,1),(peak_group(record_line,2)), 'r.','markersize',20,'Color',[0.6 0.4 0.1])
    plot(systolic_time2, Heart_wave(systolic_time2,1),'r.','markersize',40,'Color',[0 0.5 0.5])
    plot(systolic_time, peak_group(record_line(differNumber),2),'r.','markersize',30,'Color',[0.6 0.4 0.1])
    legend('Filtered Signals','Regression Curve', 'Four Near Heartbeat')
    text(systolic_time-2000, peak_group(record_line(differNumber),2)+0.03,'Final Systolic Pressure Time');
    text(systolic_time2, Heart_wave(systolic_time2,1)+0.03,'t3');
    hold off
end

% find diastolic time
for i2 = 1:length(ydiff)-highestNumber-N/4
    if ydiff2(highestNumber + i2) > 0
        diastolic_time = highestNumber + i2;
        break;
    end
end

for i2 = 1:diastolic_time-N/4
     if ydiff(diastolic_time - i2) > ydiff(diastolic_time)*0.8
         diastolic_time = diastolic_time - i2;
         break;
     end
 end

record_line = zeros(4,1);
% find the nearest 6 heart beat
for i = 3:length(peak_group)
    if peak_group(i,1) > diastolic_time
        record_line(1) = i-1;
        record_line(2) = i;
        record_line(3) = i+1;
        record_line(4) = i+2;
        break
    end
end

for i = 1:3
    differ(i) = peak_group(record_line(i+1),2) / peak_group(record_line(i),2);
end
[differValue, differNumber] = find_lowest(differ);
diastolic_time = peak_group(record_line(differNumber+1),1);



end