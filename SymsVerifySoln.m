%
% Verify the dispersion relation
%
clear;

% With dimensions
syms Kf omega w0 k muap mubp ab bb rho0 T L L2 Gs Gss K c0
X = [[omega/Kf     0    -k  omega/w0    0];
     [muap         1    0   0           mubp];
     [-ab          0    1   0           -bb];
     [-L          -L2   0   1           0];
     [-L2          L    0   0           1]];
 
X = subs(X,muap,1j*w0*k*T);
X = subs(X,mubp,omega^2 *w0 *rho0 * T);
X = subs(X,ab,k/rho0/omega*(1-T));
X = subs(X,bb,-1j*omega*T);
X = subs(X,L,1/(abs(k)*Gs));
X = subs(X,L2,1/(2j*k*Gss));
% X = X
D = expand(det(X))



% The result:
1 + (T - 1) K^2 + Lambda

+ T [  

+ Kf*(omega^2*rho0)/(4*Gss^2*k^2)
- Kf*(omega^2*rho0)/(Gs^2*abs(k)^2)
+ Kf*(k^2*w0)/(Gs*abs(k))
- Kf*(2*T*k^2*w0)/(Gs*abs(k))
- (omega^2*rho0*w0)/(Gs*abs(k))

]





% %
% %   The Old Result:
% %
% 1 + (T - 1) * K^2  +  Kf/(Gs*w0*abs(k)) 
% 
% - (T*Kf)/Gss 
% 
% - (T*omega^2*rho0)/(4*Gss^2*k^2) 
% + (T*omega^2*rho0)/(Gs^2*abs(k)^2) 
% + (T*omega^2*rho0*w0)/(Gs*Kf*abs(k))
% 
% - (T*k^2*w0)/(Gs*abs(k)) 
% + (2*T^2*k^2*w0)/(Gs*abs(k)) 



