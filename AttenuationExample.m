clear;  pause on;    tic;

CreateFracture_Basalt;

omega = M.al*logspace(-6,10,50);

M.x = omega;
M.type='FixedFrequency';
K = RootFinder(ProcVarArg(M)); toc;

rt=1;
att = imag(K(rt,:))./real(K(rt,:));
% cp = 1./real(K(rt,:));

Z0 = M.al./omega;
xi = sqrt(-1j./(Z0));
% f2 = xi.^2./(1-xi.*(1 + 2./(exp(-2*xi) - 1)));
Z2 = sqrt(M.al./omega/8);
L = M.wel./omega;

% Plot 1/(2Q)
figure;
XX = omega/ ( M.al );

loglog(XX,att,'-k','linewidth',3);hold on;
loglog(XX,ones(size(Z0))/sqrt(3),'--r');
loglog(XX,Z0,'--m');
loglog(XX,Z2,'--b');


xlabel('Frequency \omega/\alpha');
grid on;
ylim([10^-3  1]);
xlim([10.^-4 10^6]);
ylabel('Spatial Attenuation, 1/2Q');

line(M.wel./M.al*[1 1],ylim,'color','k','linewidth',1);
line([1 1],ylim,'color','k','linewidth',1);

set(gca,'xtick',10.^[-4:2:6]);

legend('General','Fully Developed','Extrapolated Fully Developed','Boundary Layer','location','southwest');

text(10.^-0.2,10^-1.0,'\omega=\alpha','rotation',90,'fontsize',24);
text(2.1*10.^3,10^-1.0,'\omega=\omega_{el}','rotation',90,'fontsize',24,'fontname','times');
text(10^-3.5,10^-2,['\omega_{el}/\alpha = ' num2str(M.wel/M.al,2)],'fontsize',24,'fontname','times');