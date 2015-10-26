% Glacier obs
clear; tic;
CreateFracture_WaterIce;
q_ob_ice = [100 3 1 7.5 3];
f_ob_ice = [8 3 1 75 6];
L_Range = 2*pi*[10^3 10^-2];
W_Range = [10^1 10^-4];

nk = 30;
nw = 40;

%
% 1.  Calculate the upper and lower bounds for the fundamental mode.
%

% The fundamental mode is lambda = 2*L
lambda_1 = 2 * L_Range(1);
lambda_2 = 2 * L_Range(2);

% k_i = 2 pi / lambda_i
logkmin = log10(2*pi/lambda_1);
logkmax = log10(2*pi/lambda_2);

logwmax = log10(W_Range(1));
logwmin = log10(W_Range(2));

k = logspace(logkmin,logkmax,nk);
wlist = logspace(logwmin,logwmax,nw);





%
% 2.  Calculate the complex frequency for each frequency/width pair using
%     the dispersion relation.
%
OM = zeros(nw,nk);
Q=OM;CP=OM;
for i = 1:nw
    w = wlist(i);
    M.wel = M.Kf*M.c0/M.Gp/w;
    M.al = M.nu/w^2;

    M.x = k;
    M.type='FixedWavenumber';
    
    omega = RootFinder(ProcVarArg(M));
    OM(i,:) = abs(real(omega(1,:)*M.c0 .* k)); 
    CP(i,:) = abs(real ( omega(1,:) ));
    Q(i,:) = abs(real(omega(1,:))./imag(omega(1,:))/2);
    toc
end

[KK,WW] = meshgrid(k,wlist);
F0 = OM/2/pi;   % Careful to convert between angular and seismic frequency.









%
% 3.  Make the plots.
%

%
%   Plot L/W contours
%
logL = log10(pi./KK);
logW = log10(WW);

QltOne = Q(:) < sqrt(3);
QQ_filt = Q;   QQ_filt(QltOne) = nan;
F0_filt = F0;   F0_filt(QltOne) = nan;


% contour(logL,logW,log10(Q),1:5,'linecolor','k','linewidth',2);hold on;
% contour(logL,logW,log10(F0),-2:4,'linewidth',2,'linecolor','r');hold on;

contour(log10(Q),log10(F0),logW,-4:1,'linecolor','k','linewidth',2);hold on;
contour(log10(Q),log10(F0),logL,-1:3,'linewidth',2,'linecolor','r');hold on;
xlabel('log10 Q');
ylabel('log10 F0');
xlim([0 7]);
ylim([-4 4]);

l_model = ( pi/64 * nu * (Gp/rhof)^2 * Q.^2 ./ F0.^5  ).^(1/6);
w_model = Q./2 .* sqrt(nu/pi./F0);
contour(log10(Q),log10(F0),log10(w_model),-4:1,'linecolor','m','linewidth',2,'linesty','--');hold on;
contour(log10(Q),log10(F0),log10(l_model),-1:3,'linecolor','m','linewidth',2,'linesty','--');hold on;