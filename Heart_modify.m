% This function is to remove strange points in Heart_wave


% How to use:
%   output = Heart_modify (input);


function output = Heart_modify (input);

% the idea is the heart wave should be smooth, any value too big or too
% small is error
% compare N's value with N-1's and N+1's value, N's value should be in 1/3
% to 2/3 of (N-1's + N+1's), if it is not, it should be compare N's and
% N+1's value with N-1's, the most different one is the error

% remove any value below than 0
for i = 2:length(input)-2
    if input(i,3)*10000 < 0
        if input(i+1,3)*10000 < 0 
            input(i,3) = input(i-1,3)*2/3 + input(i+2,3)/3;
            input(i+1,3) = input(i-1,3)/3 + input(i+2,3)*2/3;
        else
            input(i,3) = input(i-1,3)/2 + input(i+1,3)/2;
        end
    end
end

output(1,1) = input(1,1);
output(1,2) = input(1,2);
output(1,3) = input(1,3);
k = 2;
for i = 2:length(input)
    sum = input(k-1,3) + input(k+1,3);
    if input(k,3) > 2/3*sum  || input(k,3) < 1/3*sum
        % error founded
%         sum2 = input(k,2) + input(k+2,2);
%         if  input(k+1,2) > 2/3*sum2  || input(k+1,2) < 1/3*sum2 
%             k = k + 1;
%             output(i,1) = input(k,1);
%             output(i,2) = input(k,2);
%         else
            output(i,1) = input(k,1);
            output(i,2) = input(k,2);
            output(i,3) = sum/2;
            k = k + 1;
%             input(k,1) = input(k-1,1);
%             input(k,2) = input(k-1,2);
%             input(k,3) = input(k-1,3);
            input(k,3) = sum/2;
%         end
    else
        output(i,1) = input(k,1);
        output(i,2) = input(k,2);
        output(i,3) = input(k,3);
    end
    k = k + 1;
    if k+1 == length(input) || k+1 > length(input)
        break;
    end
end