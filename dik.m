function val = dik(Sr,Si,P)
%
% val = dif(Sr,Si,P) The dispersion relation for fixed wavenumber
%
S = Sr + 1j*Si;

xi = sqrt(-1j*S./P.Z);
if P.fdf == 1   % FDF
    T = 1 - xi.^2/3;
else            % Arbitrary viscous laminar flow
    T = tanh(xi)./xi;
end

% General, with background flow
% val = S.^2 + 2j*Z2.*S - 4j*P.M.*Z2 .*P.L./(1+P.L) - 1./(1 + P.L);

% General, no bg flow, vx(w)=0
val = S.^-2 .* (1 - T) - 1 - P.L;


% Dunham and Ogden, but with new notation for zeta
% val = S.^2 + 3j*P.Z.*S - 1./(1 + P.L);


% val = S.^-2 .* (-xi/3) - 1 - P.L;


% General, vx(w) natural
% val = S.^-2 .* (1 - T) - 1 - P.L + P.R * T;


% Rigid wall viscous
% val = S.^2 + 2j*Z2.*S - 1;

% Boundary layer, rigid wall
% val = S.^2 - 1 - sqrt(1j*S.^3 * 2/3 * P.Z);

% This assumes FULLY DEVELOPED viscous laminar flow
% val = S.^2 + 2*P.Z.*S + 1./(1 + P.L) + 4j*P.M.*P.Z .*P.L./(1+P.L);