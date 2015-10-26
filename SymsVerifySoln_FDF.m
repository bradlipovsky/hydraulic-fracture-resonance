%
% Verify the dispersion relation with FDF and no ux
%
clear;

% With dimensions
syms Kf omega w0 k muap mubp ab bb rho0 T L L2 Gs Gss K c0 xi al
X = [[omega/Kf     0   -k  omega/w0];
     [muap                1   0   0];
     [-ab                 0   1   0];
     [-L                  0   0   1]];

 
X = subs(X,muap,1j*w0*k*T);
X = subs(X,mubp,omega^2 *w0 *rho0 * T);
X = subs(X,ab,k/rho0/omega*(1-T));
X = subs(X,bb,-1j*omega*T);
X = subs(X,L,1/(abs(k)*Gs));
X = subs(X,L2,1/(2j*k*Gss));

% FDF Limit:
X = subs(X,T,1-xi^2/3);
X = subs(X,xi,sqrt(-1j*omega / al));

D = expand(det(X))



% The result:

