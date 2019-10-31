%Plot Earth
%Plot Mars
%Launch date, arrival date earth --> mars
%Launch date, arrival date mars --> earth
%mission lengths
%delta V for transfer

G = 6.67430E-11; %m^3/(s^2*kg)
AU = 149.598E9; %m
M_s = 1.98847E30;%kg
M_e = 5.9722E24;%kg
M_m = 6.4171E23;%kg
r_e = 1; %AU
r_m = 1.523679; %AU
s_to_days = 60*60*24;

newG = G/(AU^3)*s_to_days^2;

v_e = sqrt(newG*M_s/r_e);
v_m = sqrt(newG*M_s/r_m);

[td1, earth_loc] = ode45(@(t, state) gravity(t, state, newG, M_s), [0 1000], [r_e 0 0 v_e]);

plot(earth_loc(:,1), earth_loc(:,3))