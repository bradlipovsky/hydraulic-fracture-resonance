clear;  pause on;    tic;


% CreateFracture_Basalt;
CreateFracture_WaterRock;
k  = M.al/c0*logspace(1,6,100);
M.x = k;
M.type='FixedWavenumber';
Omega = RootFinder(ProcVarArg(M)); toc;

rt = 1;

cp = abs(real(Omega(rt,:)));
att = abs(imag(Omega(rt,:))./real(Omega(rt,:)));
cp(cp<sqrt(eps)) = 0;
cpcw = 1./sqrt(M.wel/c0./k);
% cpdsw = 1 - sqrt(M.al/8/c0./k);

kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 15/8 * kel .* al.^2/c0^2 ) .^(1/3);

%
% Figures
%
figure;
yll = [10.^-1.8 2]; %yll = get(gca,'xlim');

% subplot(2,1,1);
loglog(k*c0/M.al,cp,'-k','linewidth',3);hold on;
loglog(k*c0/M.al,cpcw,'--b');
% loglog(k*c0/M.al,cpdsw,'--g');
xlabel('Wave number, kc_0/\alpha');
ylabel('Phase Velocity, \omega_R/(k c_0)');

axis tight;
xll=xlim;
xll(2) = 10^4;
ylim(yll);
xlim(xll);
line(xll,[1 1],'color','r','linesty','--','linewidth',3);

line(kc*c0/M.al*[1 1],yll,'color','k','linewidth',1);
line(kel*c0/M.al*[1 1],yll,'color','k','linewidth',1);
grid on;
loglog(k*c0/M.al,cp,'-k','linewidth',3);hold on;
legend('General','Crack wave limit','Sound wave limit',...
        'location','southeast');
kca = kel*c0/M.al;
kcal10 = floor(log10(kca))
kcaa = round(kca/10.^kcal10);
text(10^1.5,10^0.1,['k_{el}c_0/\alpha = ' num2str(kcaa) '\times10^' num2str(kcal10)],'fontsize',24,'fontname','times');
text(kc*c0/M.al,10^-1.0,'k=k_c','rotation',90,'fontsize',24,'fontname','times');
text(2.1*10.^3,10^-1.0,'k=k_{el}','rotation',90,'fontsize',24,'fontname','times');

% subplot(2,1,2);
figure;
loglog(k*c0/M.al,abs(att),'-k','linewidth',3); hold on;
loglog(k*c0/M.al,sqrt(M.al./k/c0/8),'--r','linewidth',2); hold on;
% loglog(k*c0/M.al,atest,'--b','linewidth',2); hold on;
axis tight;

xlim(xll);
yll = 10.^[-4 4];
ylim(yll);

line(kc*c0/M.al*[1 1],yll,'color','k','linewidth',1);
line(kel*c0/M.al*[1 1],yll,'color','k','linewidth',1);
kca = kel*c0/M.al;
kcal10 = floor(log10(kca))
kcaa = round(kca/10.^kcal10);
text(10^1.5,10^-3,['k_{el}c_0/\alpha = ' num2str(kcaa) '\times10^' num2str(kcal10)],'fontsize',24,'fontname','times');
text(kc*c0/M.al,10^-3.75,'k=k_c','rotation',90,'fontsize',24,'fontname','times');
text(2.1*10.^3,10^-3.75,'k=k_{el}','rotation',90,'fontsize',24,'fontname','times');

set(gca,'xtick',10.^[1:6]);
grid on;
xlabel('Wave number, kc_0/\alpha');
ylabel('Temporal Attenuation, 1/2Q');
legend('General','Boundary layer limit', 'location','northeast');
    