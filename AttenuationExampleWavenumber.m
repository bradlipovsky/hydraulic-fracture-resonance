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
kc = (15/8*M.wel*M.al^2/c0^3)^(1/3);
cpdcw = om / kc/c0;

att = abs(imag(Omega(1,:))./real(Omega(1,:)));

sqr = sqrt(-1j*k*c0/M.al ./ sqrt(1+L));
% T = tanh(sqr)./sqr;
T = 1./sqr;
DD = sqrt(1./(1+L)) .*(1 - T/2);


Q0 = sqrt(M.al./k/c0/8) .* (1+L).^(1/4);
Qbl = Q0./(1-Q0);

Q1 = sqrt(M.al./k/c0/8) .* L.^(1/4);
Qblcw = Q1./(1-Q1);

Qblsw = sqrt(M.al./k/c0/8);

%
% Figures
%
figure;
kel = M.wel/c0;
kc = (15/8 * M.al^2/c0^2 * kel)^(1/3);
kg = k>kc;
loglog(k*c0/M.al,att,'color','k'); hold on;
% loglog(k(kg)*c0/M.al,Qblcw(kg),'--g');
loglog(k(kg)*c0/M.al,Qblsw(kg),'--r');
% loglog(k(kg)*c0/M.al,Qbl(kg),'--r');
% loglog(k(kg)*c0/M.al,abs(imag(DD(kg))./real(DD(kg))),'-g');
ylim(10.^[-4 4]);
xlim(10.^[1 6]);
line(kc*c0/M.al*[1 1],10.^[-4 4],'color','k','linewidth',1);
line(kel*c0/M.al*[1 1],10.^[-4 4],'color','k','linewidth',1);
% grid on;
xlabel('Wavenumber, kc_0/\alpha');
ylabel('Temporal Attenuation, 1/2Q');
set(gca,'xtick',10.^(1:6));

% legend('General','Boundary Layer, Crack wave','Boundary Layer, Sound wave','Boundary Layer');
legend('General','Boundary Layer, Sound Wave');

text(kc*c0/M.al,10^-3.5,'k=k_c','rotation',90,'fontsize',24,'fontname','times');
text(kel*c0/M.al,10^-3.5,'k=k_{el}','rotation',90,'fontsize',24,'fontname','times');