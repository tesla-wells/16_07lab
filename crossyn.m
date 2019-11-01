function [value, isTerminal, direction] = crossyn(t, state)
    value = state(2);
    isTerminal = 1;
    direction = 0;
end