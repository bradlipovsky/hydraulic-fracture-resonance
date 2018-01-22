% Till
rhor = 916.7;
cpr = 3600;
csr = 200;
G = csr^2 * rhor;
poi = (rhor*cpr^2 - 2*G)/(rhor*2*cpr^2-2*G);
Gp = csr^2 * rhor / (1-poi);

% Water
rhof = 1000;
c0 = 1403.1;
Kf = c0^2 * rhof;
mu = 1.8*10^-3;
nu = mu/rhof;

w =  0.001;

M.wel = Kf*c0/Gp/w;
M.al = nu/w^2;
M.w0 = w;

M.nu = nu;
M.Kf = Kf;
M.Gp = Gp;
M.c0 = c0;