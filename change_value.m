% This function is change the record digital value into "mm Hg"


% How to use:
%   pressure = change_value(value)
% Argument details:
%   pressure: value in mm Hg
%   value: value by digital recorded

function pressure = change_value(value);

pressure = (value+0.1)/0.0025;

end