function [dStatedt] = gravity(t, state_vec, G, M)
    x = state_vec(1);
    y = state_vec(2);
    xdot = state_vec(3);
    ydot = state_vec(4);
    
    r = sqrt(x^2 + y^2);
    
    accel = G*M/r^2;
    
    xddot = -x/r * accel;
    yddot = -y/r * accel;
    
    dStatedt = zeros(4, 1);
    
    dStatedt(1) = xdot;
    dStatedt(2) = ydot;
    dStatedt(3) = xddot;
    dStatedt(4) = yddot;

end