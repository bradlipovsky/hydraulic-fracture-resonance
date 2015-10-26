clear; pause on; tic;

nx = 1000;
x = linspace(0,100,nx);
nt = 100;
t = linspace(0,1000,nt);
b = zeros(size(x));
range = (round(nx/2) - round(nx * 0.1) ):(round(nx/2) + round(nx * 0.1));
b(range)=10^-5;
z = zeros(nt,nx);

%
%
%

N = length(x);

h = x(2)-x(1);
if norm(diff(x)-h)>1e-11
    disp('error, must have uniform grid spacing')
    return
end

% wavenumber
kN = pi/h; % Nyquist wavenumber
k = zeros(1,N);
k(1:N/2+1) = 2*[0:N/2]/N;
k(N:-1:N/2+2) = -k(2:N/2);
k = k*kN;

% b(x) = excitation
b_mean = mean(b);

% excitation in Fourier domain
B = fft(b-b_mean);
B(N/2+1) = B(N/2+1)/2; % handle Nyquist properly

% dispersion relation

% for real valued k the crackwave dispersion relation only depends on |k|.
% So we can just treat the positive half of the wavenumbers and then
% reflect the solutions to the negative part of the line.

CreateFracture;

klog  = M.al/c0*logspace(1,9,100);
M.x = klog;
M.type='FixedWavenumber';
Omega = RootFinder(ProcVarArg(M)); toc;

rt = 1;
cp = real(Omega(rt,:));
cp(cp<sqrt(eps)) = 0;

%
% Interpolate on to k from klog (the root finder works better in log space.
%
omega = interp1(klog,Omega(rt,:),abs(k));
omega(k==0) = 0;
L = M.wel/c0./abs(k);
L2 = L./(1+L);
L2(1) = 1; % inf/inf -> 1

%
% Iterate in time
%
for ti = 1:nt
    CosTerm = cos(omega*t(ti));
    SinTerm = M.al./omega .*sin(omega*t(ti));
    SinTerm(omega==0) = M.al*t(ti);
    Z = B/2 .* L2 *exp(-M.al*t(ti)) .* (CosTerm + SinTerm); 
  

%     Z = B .* L *exp(-M.al*t(ti)) .* (CosTerm + SinTerm); 
    
    z(ti,:) = ifft(Z)+b_mean;
end




% 
% Plot
%
ma = max(abs(z(:)));
me = mean(abs(z(:)));
for tt = 1:nt
    figure(1);
    plot(x,real(z(tt,:))-ma ); hold on;
    ylim([me ma]); hold off;
    pause(0.1);
end