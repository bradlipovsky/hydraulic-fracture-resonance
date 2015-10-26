clear;  pause on;    tic;

%
% log10 Zeta = 5, log10 Omega = -5
% 

M.wel = 10;
M.al = 10;

omega = M.wel*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M));
K=Kn(1,:);

xi = sqrt(-1j*omega./M.al);

ufd = abs(K) .* omega/M.al/3; 
ubl = abs(K);           
taufd = abs(xi.^2 .* K);  
taubl = abs(xi .* K); 

abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);


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




%
% log10 Zeta = -5, log10 Omega = 5
% 

M.wel = 10^-10;
M.al = 1;

omega = M.al*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M));
K=Kn(1,:);

xi = sqrt(-1j*omega./M.al);

ufd = abs(K) .* omega/M.al/3; 
ubl = abs(K);           
taufd = abs(xi.^2 .* K);  
taubl = abs(xi .* K); 

abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);


omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);

subplot(2,2,2); % axes(ha(1));
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







%
% log10 Zeta = -5, log10 Omega = -5
% 

M.wel = 1;
M.al = 10^-10;

omega = M.wel*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M));
K=Kn(1,:);

xi = sqrt(-1j*omega./M.al);

ufd = abs(K) .* omega/M.al/3; 
ubl = abs(K);           
taufd = abs(xi.^2 .* K);  
taubl = abs(xi .* K); 

abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);


omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);

subplot(2,2,3); % axes(ha(1));
omi = 1;
u = abar(omi)*p / ubl(omi);
tau = Ttp(omi)*p / taubl(omi);
px = -1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{FD}',' \tau / \tau_{FD}',' p / A','location','northeast');
title(['Boundary Layer Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),1) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
xlabel('\omega t / \pi');
grid on;









%
% log10 Zeta = -5, log10 Omega = 5
% 

M.wel = 10;
M.al = 10;

omega = M.wel*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
Kn = RootFinder(ProcVarArg(M));
K=Kn(1,:);

xi = sqrt(-1j*omega./M.al);

ufd = abs(K) .* omega/M.al/3; 
ubl = abs(K);           
taufd = abs(xi.^2 .* K);  
taubl = abs(xi .* K); 

abar = K.*(1 - tanh(xi)./xi);
Ttp = K.*xi.*tanh(xi);


omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);

subplot(2,2,4); % axes(ha(1));
omi = numel(omega);
u = abar(omi)*p / ubl(omi);
tau = Ttp(omi)*p / taubl(omi);
px = -1j*K(omi)*p / abs(K(omi));
plot(omegat/pi,real(u),'ok');hold on;
plot(omegat/pi,real(tau),'-k');
plot(omegat/pi,real(px),'-m'); %dp/dx
plot(omegat/pi,real(p),'-r');
legend(' u / u_{FD}',' \tau / \tau_{FD}',' p / A','location','northeast');
title(['Boundary Layer Limit, log_{10} \zeta = ' num2str(log10(M.al/omega(omi)),1) ...
       ', log_{10} \Omega = ' num2str(log10(omega(omi)/M.wel),1)]);
ylim([-1.25 1.25]);
xlabel('\omega t / \pi');
grid on;