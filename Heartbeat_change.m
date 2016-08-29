% This function is to plot a wave based on the ECG signal
% Ideally, this wave will be ploting the peaks of each ECG sample ('R' part)

% How to use:
%   Heart_wave = Heatbeat_change(Heartbeat)
% Argument details:
%   Heart_wave: the final wave signal
%       :,1  simulating curve
%       :,2  1st-order derivative of simulating curve
%       :,3  2nd-order derivative of simulating curve
%       :,4  each "R"'s time
%       :,4  each "Q"'s time
%   Heartbeat: the heartbeat data

function Heart_wave = Heartbeat_change(Heartbeat)

% find each peak
% How to fin the first peak:
%   1> the peaks' value at the beginning is simllar (no bloodstream)
%   2> ingore the part I cut off (0 part at the beginning), there will
%   always be at least one heartbeat at the first 1.5 s (1.5s = 1500 samples)

global N

peak_group = find_peak(Heartbeat);



xdata = peak_group(:,1);
xdata2 = peak_group(:,2);
ydata = peak_group(:,3);

% modify Heart_wave, remove some error points (too high or too low)


global test_set

if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Filtered Signals with marked R and Q point');
    xlabel('Time (ms)');
    hold on 
    plot(xdata, Heartbeat(xdata),'Color',[1 0.1 0.1]);
    plot(xdata2, Heartbeat(xdata2),'Color',[0.5 0.5 0.5]);
    legend('Filtered Signals','R', 'S')
    hold off    
end
if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Filtered Signals vs Heartbeat Amplitude signals');
    xlabel('Time (ms)');
    hold on 
    plot(xdata, ydata);
    legend('Filtered Signals','Heartbeat Amplitude');
    hold off
end

peak_group = Heart_modify(peak_group);
xdata = peak_group(:,1);
xdata2 = peak_group(:,2);
ydata = peak_group(:,3);


if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Filtered Signals vs Heartbeat Strength signals after modified');
    xlabel('Time (ms)');
    hold on 
    plot(xdata, ydata);
    legend('Filtered Signals','Heartbeat Amplitude');
    hold off
end

global polyfit_degree
p = polyfit(xdata,ydata,polyfit_degree);
x = (N:length(Heartbeat)-N/4);
y = polyval(p,x);
ydiff = diff(y);
ydiff2 = diff(y,2);

% add '0' at the beginning and end

A_y_before(1:N) = 0;
A_y_after(1:N/4) = 0;
y = [A_y_before y A_y_after];
ydiff = [A_y_before 0 ydiff 0 A_y_after];
ydiff2 = [A_y_before 0 ydiff2 0 A_y_after];

if test_set == 1
    % plot it if test
    figure
    plot(Heartbeat)
    title('Filtered Signals vs Regression Curve');
    xlabel('Time (ms)');
    hold on 
    plot(y);
    legend('Filtered Signals','Regression Curve');
    hold off
end

for i = 1: length(y);
    Heart_wave(i,1) = y(i);
    Heart_wave(i,2) = ydiff(i);
    Heart_wave(i,3) = ydiff2(i);
    if i < length(peak_group)+1
        Heart_wave(i,4) = peak_group(i,1);
        Heart_wave(i,5) = peak_group(i,3);
    end
end