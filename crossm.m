function [value, isTerminal, direction] = crossm(t, state)
%hard code value found earlier
    r_m = 1.523679; %AU

    x = state(1);
    y = state(2);

    value = r_m - sqrt(x^2 + y^2);
    isTerminal = 0;
    direction = 0;
    
end