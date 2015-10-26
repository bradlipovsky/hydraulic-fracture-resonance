function val = dif(Kr,Ki,P)
%
% val = dif(Kr,Ki,P) The dispersion relation
%

K = Kr + 1j*Ki;

% ff = f(K,P);
% f0 = fold(P);
% val = abs(K).*(K.^2 - (1+2j*P.Z*ff)) ...
%     + 2j*P.M*P.Z*ff.*K.*P.m*P.L - P.L*(1+2j*P.Z*ff);

% Old way of writing it.
% ff = fold(P);
% val = abs(K).*(K.^2 - (1+2j*P.Z*ff)) - P.L*(1+2j*P.Z*ff);

% General
xi = sqrt(-1j ./(P.Z) );
% val = K.^2 .* (1 - tanh(xi) ./ xi) - 1 - P.L./abs(K) + P.R * tanh(xi)./xi;

% Correct def of |K|
Ks = sign(real(K)) .* K;

% vx(w) = 0
val = K.^2 .* (1 - tanh(xi) ./ xi) - 1 - P.L./ Ks;

% CW limit
% val = K.^2 .* (1 - 1 ./ xi) - 1 - P.L./ Ks;

% Rigid walls
% val = K.^2 - 1./(1 - tanh(xi) ./ xi);

% Rigid walls and boundary layer
% val = K.^2  - 1./(1 - 1 ./ xi);


% omega < alpha < omega_el limit
% val = Ks.*K.^2 - 3j*P.L.*P.Z;

% vx(w) natural
% val = K.^2 .* (1 - tanh(xi) ./ xi) - 1 - P.L./ Ks - P.R * tanh(xi)./xi;

% % With tau-vx coupling
% T = tanh(xi) ./ xi;
% A = P.L./ Ks .* (P.w0 * P.xx /P.c0).^2;
% val = K.^2 .* (1 - 1./(T.^-1 + A) ) - 1 - P.L./ Ks - P.R ./(T.^-1 + A);

% With tau-w coupling
% val = K.^2 .* (1 - tanh(xi) ./ xi) - 1 - P.L./ Ks - P.R * tanh(xi)./xi ...
%     + P.R.*K.^-1 * (1 + P.R.*K.^-2) * tanh(xi)./xi ;


% HF limit
% val = K.^2  - (1 + P.R)./xi - 1;

% BL Limit
% val = K.^2 .* (1 - 1 ./ xi) - 1 - P.L./abs(K) + P.R * 1./xi;

% FDF Limit  % This describes damped crack waves
% val = K.^2  - 2j*P.Z*(1 + P.L./ (abs(K) - P.R) - P.R;

% Removes any root at the origin.
% val = val./abs(K);

% if P.ed == 1    % Use (e)lasto(d)ynamics
%     vpvs = (P.cp/P.cs)^2;
%     poi = 0.5*(vpvs - 2)/(vpvs - 1);
%     P.L = P.L*F(K,poi,P.cs,P.cp,P.c0);
% end
    
% "Biot Slow Waves"
% val = K.^2 - (1+2j*Z);

% Full dispersion without RD
% For viscous laminar, m=4 and n=0
% val = abs(K).*(K.^2 - (1+2j*Z*f)) + 1j*M*Z*f*K.*(m*L+n) - L*(1+2j*Z*f);

% As above, but with oblique perturbations
% This assumes viscous laminar

% val = abs(K).*(K.^2 - (1+2j*P.Z*P.f))...
%     + 2j*P.M*P.Z*(2*cos(P.thet)*P.f + sin(P.thet))*K.*P.m*P.L...
%     - P.L*(1+2j*P.Z*P.f);




% 
% function val = f(K,P)
% C = (1 - P.R * K.^-2);
% xi = sqrt(-1j ./(2/3 * P.Z) );
% 
% % General laminar viscous, vx(w)=0
% % val = 1/3 * xi.^2 ./ (xi.*coth(xi) - 1);   
% 
% % General laminar viscous, general vx(w)
% val = 1/3 * xi.^2 .* C./ (xi.*coth(xi) - C);
% 
% % Fully developed flow, general vx(w)
% % val = 1/3*xi.^2 .* C./(1 - C);
% 
% 
function val = fold(P)
xi = sqrt(-1j ./(2/3 * P.Z) );

% General laminar viscous, vx(w)=0
val = 1/3 * xi.^2 ./ (xi.*coth(xi) - 1);   

