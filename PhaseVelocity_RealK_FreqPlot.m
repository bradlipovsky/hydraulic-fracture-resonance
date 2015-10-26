clear;  pause on;    tic;

CreateFracture_Basalt;
k  = M.al/M.c0*logspace(1,6,100);  %Good for magma
M.x = k;
M.type='FixedWavenumber';
Omega = RootFinder(ProcVarArg(M)); toc;
om = abs(real(Omega(1,:)) .* k * c0);

cp = abs(real(Omega(1,:)));
% cp(cp<sqrt(eps)) = 0;
zeta = M.al ./ om;
L = M.wel ./ om;
cpzcw = (zeta.*L).^(-1/3);
cpcw = (om./M.wel).^(1/3);
% % cpdcw = (om.^3./M.wel/M.al.^2).^(1/3);
kc = (9/4*M.wel*M.al^2/c0^3)^(1/3);
cpdcw = om / kc/c0;

att = imag(Omega(1,:))./real(Omega(1,:));


%
% Figures
%
figure;

X = om/M.wel;
loglog(X,cp,'-k','linewidth',3);hold on;
loglog(X,cpcw,'--b');
loglog(X,cpdcw,'--m');
loglog(X,cp,'-k','linewidth',3);hold on;
% loglog(om/al,cpzcw,'--g');
xlabel('Frequency, \omega/\omega_{el}');
ylabel('Phase Velocity, \omega/(k c_0)');

axis tight;
% xll = get(gca,'xlim');
xll = 10.^[-4.75 1.75];
xlim(xll);
yll = [10.^-2 2]; %yll = get(gca,'xlim');
ylim(yll);
line(xll,[1 1],'color','r','linesty','--','linewidth',3);


% Alpha
line(M.al./M.wel*[1 1],yll,'color','k','linewidth',1);

% Lambda elastic

line([1 1],yll,'color','k','linewidth',1);
grid on;


% legend('General','Crack wave limit','Sound wave limit','location','southeast');
