clear;  pause on;    tic;

CreateFracture;
k  = M.al/M.c0*logspace(1,6,75);  %Good for magma
M.x = k;
M.type='FixedWavenumber';
Om = RootFinder(ProcVarArg(M)); toc;

omega = Om(2,:) .*k*c0;
xi = sqrt(-1j./(M.al./omega));

T = tanh(xi)./xi;
Tup = (1 - T)./Om(2,:);

omegat = linspace(0,3*pi,numel(omega));
p = exp(-1j*omegat);

figure;

omi = 1;
u = Tup(omi)*p;

plot(omegat/pi/2,real(u));

xlabel('\omega t / (2\pi)');
grid on;
