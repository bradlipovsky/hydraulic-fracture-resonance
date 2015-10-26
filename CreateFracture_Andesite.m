% Rock (assume poi=0.25)
rhor = 2700;
cpr = 5000;
poi = 0.25;
M.poi=poi; M.G = cpr^2/3 * rhor;
Gp  = cpr^2/3 * rhor / (1-poi);
Gpp = cpr^2/3 * rhor / (1-2*poi);

% Magma
rhof = 2500;
c0 = 1000; 
Kf = c0^2 * rhof;  
mu = 10^5;
nu = mu/rhof;

w = 1;

M.wel = Kf*c0/Gp/w;
M.al = nu/w^2;
M.w0 = w;

M.nu = nu;
M.Kf = Kf;
M.Gp = Gp;
M.c0 = c0;