function [dStatedt] = differenceMachine(t, state_vec, G, M)

    dStatedt = zeros(8, 1);

    x = state_vec(1);
    y = state_vec(2);
    xdot = state_vec(3);
    ydot = state_vec(4);
    
    r = sqrt(x^2 + y^2);
    
    accel = G*M/r^2;
    
    xddot = -x/r * accel;
    yddot = -y/r * accel;
    
    dStatedt(1) = xdot;
    dStatedt(2) = ydot;
    dStatedt(3) = xddot;
    dStatedt(4) = yddot;
    
    xm = state_vec(5);
    ym = state_vec(6);
    xdotm = state_vec(7);
    ydotm = state_vec(8);
    
    rm = sqrt(xm^2 + ym^2);
    
    accelm = G*M/rm^2;
    
    xddotm = -xm/rm * accelm;
    yddotm = -ym/rm * accelm;
    
    
    dStatedt(5) = xdotm;
    dStatedt(6) = ydotm;
    dStatedt(7) = xddotm;
    dStatedt(8) = yddotm;

end