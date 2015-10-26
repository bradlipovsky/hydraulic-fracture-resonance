% Rock (assume poi=0.25)
rhor = 2700;
% cpr = 50000;
cpr = 5000;
poi = 0.25;
M.poi=poi; M.G = cpr^2/3 * rhor;
Gp  = cpr^2/3 * rhor / (1-poi);
Gpp = cpr^2/3 * rhor / (1-2*poi);

% Steam
rhof = 10;
c0 = 600;
Kf = c0^2 * rhof;
mu = 10^-5;
nu = mu/rhof;

w = 0.1;

M.c0 = c0;
M.wel = Kf*c0/Gp/w;
M.al = nu/w^2;
M.R = Kf / Gpp;
M.w0 = w;