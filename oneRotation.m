function [value, isTerminal, direction] = crossy(t, state)
    value = state(2);
    isTerminal = 1;
    direction = 1;
end