clear

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

%Problem 1%

options = odeset('RelTol', 1e-5, 'Events', @crossy);

%boundary conditions for earth
v_e = sqrt(newG*M_s/r_e)
v_m = sqrt(newG*M_s/r_m);

boundearth = [r_e 0 0 v_e];
boundmars = [r_m 0 0 v_m];

%Run and plot the orbits

[td1, earth_loc] = ode45(@(t, state) gravity(t, state, newG, M_s), [0 1000], boundearth, options);
[td2, mars_loc] = ode45(@(t, state) gravity(t, state, newG, M_s), [0 1000], boundmars, options);

figure(1)
hold on
plot(earth_loc(:,1), earth_loc(:,2))
plot(mars_loc(:,1), mars_loc(:,2))
hold off

%Periods calculated using ODE event and using the equation 2*pi*sqrt(a^3/(mu))
period_e = 2*pi*sqrt(r_e^3 / (newG*M_s))
period_ie = td1(end);
period_m = 2*pi*sqrt(r_m^3 / (newG*M_s));
period_im = td2(end);

s_to_years = 60*60*24*period_e;

% Problem 2 


%Boundary conditions
a = (r_e + r_m)/2 ;
v_hp = sqrt(2*(newG*M_s/r_e - newG*M_s/(2*a)));
transbounds = [r_e 0 0 v_hp];

options = odeset('RelTol', 1e-5, 'Events', @crossyn);
[td3, transfer] = ode45(@(t, state) gravity(t, state, newG, M_s), [0 1000], transbounds, options);


%Periods calculated divided by 2
period_t = 2*pi*sqrt(a^3 / (newG*M_s))/2
%Earth to mars derived
period_it = td3(end)

%deltav from earth to transfer
deltv_et = v_hp - v_e

%velocity at apogee
v_ha = sqrt(2*(newG*M_s/r_m - newG*M_s/(2*a)));
transboundsa = [(-1*r_m) 0 0 (-1*v_ha)];

options = odeset('RelTol', 1e-5, 'Events', @crossy);
[td4, transferback] = ode45(@(t, state) gravity(t, state, newG, M_s), [0 1000], transboundsa, options);

%period to come back
period_itback = td4(end);

%delta v
deltv_mt = v_ha - v_m

odeset('RelTol', 1e-5, 'Events', @crossy);
%symmetric for the other way around 
%Show using ODE if have more time :)

%plot
figure(2)
hold on 
plot(earth_loc(:,1), earth_loc(:,2))
plot(mars_loc(:,1), mars_loc(:,2))
plot(transfer(:,1), transfer(:,2))
plot(transferback(:,1), transferback(:,2))
hold off

%New bounds!
newG = G/(AU^3)*s_to_years^2
v_e = sqrt(newG*M_s/r_e);
v_m = sqrt(newG*M_s/r_m);

start_e = 104/180*pi;
boundearth = [(r_e*cos(start_e)) (r_e*sin(start_e)) (-v_e*sin(start_e)) (v_e*cos(start_e))];
start_m = 216/180*pi;
boundmars = [(r_m*cos(start_m)) (r_m*sin(start_m)) (-v_m*sin(start_m)) (v_m*cos(start_m))];

boundboth = [(r_e*cos(start_e)) (r_e*sin(start_e)) (-v_e*sin(start_e)) (v_e*cos(start_e)) (r_m*cos(start_m)) (r_m*sin(start_m)) (-v_m*sin(start_m)) (v_m*cos(start_m))]

mars_moves = period_t/period_m*2*pi;
angle_toGo = pi - mars_moves

earth_moves = period_it/period_e*2*pi
angle_toReturn = pi - earth_moves

options = odeset('RelTol', 1e-5, 'Event', @toMars);
[td5, planet_locs, timesWhenEqual, statesWhenEqual, ~ ] = ode45(@(t, state) differenceMachine(t, state, newG, M_s), [0 10], boundboth, options);

scatter((timesWhenEqual + 2020), (timesWhenEqual + 2020 + period_t/period_e))

options = odeset('RelTol', 1e-5, 'Event', @toEarth);
[td6, planet_locs2, timesWhenEqual2, statesWhenEqual2, ~ ] = ode45(@(t, state) differenceMachine(t, state, newG, M_s), [0 10], boundboth, options);

timesWhenEqual

scatter((timesWhenEqual2 + 2020), (timesWhenEqual2 + 2020 + period_t/period_e))

% Problem 3 %

