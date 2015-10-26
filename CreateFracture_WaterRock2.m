% Rock (assume poi=0.25)
% rhor = 2700;
% cpr = 5000;
% poi = 0.25;
% M.poi=poi; M.G = cpr^2/3 * rhor;
Gp  = 2.2057e10;

% Water
rhof = 1000;
Kf = 2.25e9;
c0 = sqrt(Kf/rhof);
mu = 1e-3;
nu = mu/rhof;

w = 0.001;

M.wel = Kf*c0/Gp/w;
M.al = nu/w^2;
M.w0 = w;

M.nu = nu;
M.Kf = Kf;
M.Gp = Gp;
M.c0 = c0;