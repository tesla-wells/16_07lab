function [value, isTerminal, direction] = toMars(t, state)
%hard code value found earlier
    angleToGo = 0.7740;

    xe = state(1);
    ye = state(2);
    xm = state(5);
    ym = state(6);

    anglee = atan2(ye , xe);
    anglem = atan2(ym , xm);
    
    diff = anglem - anglee;
    
    if diff < -pi
       diff = diff + 2*pi ;
    end
    if diff > pi
       diff = diff - 2*pi;
    end

    value = diff - angleToGo;
    isTerminal = 0;
    direction = -1;
    
end