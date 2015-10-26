clear;  pause on;    tic;

CreateFracture_Basalt;
% k  = logspace(-3.9,4,100);
k  = logspace(-4,4,100);
M.x = k;
M.type='FixedWavenumber';
omega = RootFinder(ProcVarArg(M)); toc;

rt=1;
cp = abs(real(omega(1,:)));
om = abs(cp.*k.*c0);
omm = om/(3*M.al);

cpdcw = (om.^3/M.wel/M.al^2).^(1/3);
attLF = abs(imag(omega(rt,:)))./cpdcw;
att = imag(omega(1,:))./real(omega(1,:));
number=5/4;

%
% Plot
%
figure;
% subplot(2,1,1);
loglog(omm,abs(att),'-k','linewidth',3); hold on;
loglog(omm,number*M.al./om,'--r','linewidth',2);
loglog(omm,sqrt(M.al./om/8),'--b','linewidth',2);
% loglog(omm,abs(att),'-k','linewidth',3); hold on;
set(gca,'fontsize',20);
xlabel('Frequency, Re \omega/\alpha');
ylabel('Temporal Attenuation, 1/(2Q)');
set(gca,'xtick',10.^(-2:2:6));
set(gca,'ytick',10.^[-2 -1 0]);
xlim(10.^[-2 6]);
ylim(10.^[-2.5 0.5]);
grid on;

legend('General','Fully Developed','Boundary Layer');
% 
% subplot(2,1,2);
% loglog(k*c0/M.al,abs(att),'-k','linewidth',3); hold on;
% xlim(10.^[1 5]);
% ylim(10.^[-5 5]);
% set(gca,'xtick',10.^(1:5));
% grid on;

kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 15/8 * kel .* al.^2/c0^2 ) .^(1/3);

yll=ylim;
line([1 1],yll,'color','k','linewidth',1);
line(kel*c0/M.al*[1 1],yll,'color','k','linewidth',1);
kca = kel*c0/M.al;
kcal10 = floor(log10(kca))
kcaa = round(kca/10.^kcal10);
% text(10^1.5,10^-3,['k_{el}c_0/\alpha = ' num2str(kcaa) '\times10^' num2str(kcal10)],'fontsize',24,'fontname','times');
% text(kc*c0/M.al,10^-3.75,'k=k_c','rotation',90,'fontsize',24,'fontname','times');
% text(2.1*10.^3,10^-3.75,'k=k_{el}','rotation',90,'fontsize',24,'fontname','times');
