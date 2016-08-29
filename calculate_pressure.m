% This function is detemine systolic and diastolic pressure based on time


% How to use:
%   [systolic_pressure, diastolic_pressure] = cacluate_pressure(Pressure,systolic_time, diastolic_time)
% Argument details:
%   systolic_pressure: systolic pressure
%   diastolic_pressure: diastolic pressure
%   Pressure: the pressure wave (the second output of function filter sample)
%   systolic_time: which sample (or when) is the systolic pressure
%   diastolic_time: which sample (or when) is the diastolic pressure

function [systolic_pressure, diastolic_pressure] = calculate_pressure(Pressure,systolic_time, diastolic_time)

systolic_pressure = Pressure(systolic_time);
diastolic_pressure = Pressure(diastolic_time);

global test_set
if test_set == 1
   figure
   plot(Pressure);
   title('Final pressure');
   xlabel('Time (ms)');
   hold on
   plot(systolic_time, systolic_pressure,'r.','markersize',30,'Color',[0.6 0.4 0.1])
   plot(diastolic_time, diastolic_pressure,'r.','markersize',30,'Color',[0.3 0.2 0.8])
   text(systolic_time-10000, systolic_pressure+10,'Systolic Pressure');
   text(diastolic_time-10000, diastolic_pressure+10,'Diastoli Pressure')
   hold off
end

end