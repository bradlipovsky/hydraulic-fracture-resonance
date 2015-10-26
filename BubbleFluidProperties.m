
n = 0.01;
R = 8.314;
h = 500;
g = 9.8;
p = 2200 * g * h;
T = 400;

rhof = 2200;

rhog = p / R / T;

rho = (( n/rhog + (1-n)/rhof))^-1