clear;  pause on;    tic;

%
% log10 Zeta = -5, log10 Omega = 5
% 
CreateFracture_SteamRock;
omega = M.wel*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M)); toc;

ind = 1;
K=Kn(ind,:);

% lel = 2*pi*Gp * w / Kf;
% l = 2*pi./abs(K);
% L = l/lel;

xi = sqrt(-1j*omega./M.al);
% ff = zet(xi);

% Different normalizations
ufd = abs(K) .* omega/M.al/3;   % FDF Norm
ubl = abs(K);                   % BL Norm
taufd = abs(xi.^2 .* K);        % FDF Norm
taubl = abs(xi .* K);           % BL Norm

% Tvx0p = K.*( 1 - 1./cosh(xi) );  
abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);
% Pup = -atan2(imag(abar),real(abar));
% Ptp = -atan2(imag(Ttp),real(Ttp));
% Pvx0p = -atan2(imag(Tvx0p),real(Tvx0p));
%
%
% Make another figure that plots Re exp(i(kx - omega t)) 
%   for each wave
%
%
%

omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);
figure;
subplot(2,2,1); % axes(ha(1));
omi = 1;
u = abar(omi)*p / ufd(omi);
tau = Ttp(omi)*p / taufd(omi);
px = -1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{FD}',' \tau / \tau_{FD}',' p / A','location','northeast');
title(['Fully Developed Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),1) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
xlabel('\omega t / \pi');
grid on;

subplot(2,2,2); % axes(ha(2));
omi = numel(omega);
u = abar(omi)*p / ubl(omi);
tau = Ttp(omi)*p / taubl(omi);
px = 1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{BL}',' \tau / \tau_{BL}',' p / A','location','northeast');
title(['Fully Developed Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),1) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
grid on;
xlabel('\omega t / \pi');












%
% Change viscosity
%


CreateFracture_Andesite;
omega = M.al*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M)); toc;

ind = 1;
K=Kn(ind,:);

lel = 2*pi*Gp * w / Kf;
l = 2*pi./abs(K);
L = l/lel;

xi = sqrt(-1j*omega./M.al);
ff = zet(xi);

% Different normalizations
ufd = abs(K) .* omega/M.al/3;   % FDF Norm
ubl = abs(K);                   % BL Norm
taufd = abs(xi.^2 .* K);        % FDF Norm
taubl = abs(xi .* K);           % BL Norm

Tvx0p = K.*( 1 - 1./cosh(xi) );  
abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);
Pup = -atan2(imag(abar),real(abar));
Ptp = -atan2(imag(Ttp),real(Ttp));
Pvx0p = -atan2(imag(Tvx0p),real(Tvx0p));
%
%
% Make another figure that plots Re exp(i(kx - omega t)) 
%   for each wave
%
%
%

omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);
% figure;
subplot(2,2,3); % axes(ha(1));
omi = 1;
u = abar(omi)*p / ufd(omi);
tau = Ttp(omi)*p / taufd(omi);
px = -1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{FD}',' \tau / \tau_{FD}',' p / A','location','northeast');
title(['Fully Developed Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),1) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
xlabel('\omega t / \pi');
grid on;

subplot(2,2,4); % axes(ha(2));
omi = numel(omega);
u = abar(omi)*p / ubl(omi);
tau = Ttp(omi)*p / taubl(omi);
px = 1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{BL}',' \tau / \tau_{BL}',' p / A','location','northeast');
title(['Fully Developed Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),2) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
grid on;
xlabel('\omega t / \pi');

