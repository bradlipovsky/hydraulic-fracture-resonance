clear;

syms k c o R xi z w rho dp nu Kf
xi = sqrt(-1j*o/nu * w^2);
% Kf = c^2*rho;

v = k/rho/o * ( 1 + (R* (o/k/c)^2 - 1) * cosh(xi*z/w)/cosh(xi)) * dp;

% Verify v satisfies governing equations
simplify ( nu * diff(v,z,2) + 1j*o*v - 1j*k * dp/rho );

% Verify dv/dz at 0 = 0
subs(diff(v,z,1),z,0);

% Verify v(z=w) = dpsomething
simplify(subs(v,z,w));

u = simplify(int(v,z,0,w)/w)