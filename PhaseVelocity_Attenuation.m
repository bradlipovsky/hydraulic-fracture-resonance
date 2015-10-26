clear;  pause on;    tic;

CreateFracture_Basalt;
omega = M.al*logspace(-10,10,75);
M.x = omega;
M.type='FixedFrequency';
P = ProcVarArg(M);
[K, fval, ef] = RootFinder(P); toc;

%
% Derived quantities
%
rt = 1;
cp =  abs ( 1./real(K(rt,:)) );


Z0 = M.al./omega;
xi = sqrt(-1j./(Z0));
% Z2 = Z0.*real(xi)/3;
% Z3 = (M.R + 1) /4 ./ sqrt(omega*w^2 / 2 / nu);
KLF= (3j*P.L.*P.Z).^(1/3);
ZZZ=abs(imag(KLF)./real(KLF));
Z3 = sqrt(Z0/8);
Z4 = sqrt(Z0/9);

kc = (9/4*M.wel*M.al^2/c0^3)^(1/3);

% XX = omega/M.wel;
XX = omega/ ( M.al );


cpbsw = sqrt(2/3*omega./M.al);
cpcw = (omega./M.wel).^(1/3);

% cpzcw = sqrt(3)/2 / 3^(1/3) * (M.al ./ omega.* M.wel./omega).^(-1/3);
cpzcw = 2/sqrt(3) / 3^(1/3) * (M.al ./ omega.* M.wel./omega).^(-1/3);

cpdcwk = omega / kc/c0;
% cpdcwk = (omega.^3/M.wel/M.al^2).^(1/3);

% att = abs(imag(K(rt,:))./real(K(rt,:)));
att = abs(imag(K(rt,:))./real(K(rt,:)));






%
% Make Figure
%
figure;

% ha = tight_subplot(2, 1, 0.025, [0.1 0.1], [0.15 0.02]);

% Plot Phase Velocity
% axes(ha(1)); 
% subplot(2,1,1);
loglog(XX,cp,'-k','linewidth',3); hold on;
loglog(XX,ones(size(cp)),'--k');
% loglog(XX,cpbsw,'--m');
loglog(XX,cpcw,'--b');
loglog(XX,cpzcw,'--r');
% loglog(XX,cpdcwk,'--r');
% loglog(XX,cp,'-k','linewidth',3); hold on;


% title(['\alpha = ' num2str(M.al,2) 's^{-1}, \omega_{el} = ' num2str(M.wel,2) 's^{-1}']);
grid on;
yll = [10^-2.6 2];
xll = [10.^-2 10^6];
ylim(yll);
xlim(xll);
ylabel('Phase Velocity, c/c_0');

legend('General solution','Sound wave (Inviscid)',...
    'Crack wave (BL)','Crack wave (FDF)',...
    'location','southeast');
% legend('General solution','Sound wave (Inviscid fluid)','Sound wave (Fully developed)',...
%     'Crack wave (Inviscid fluid)','Crack wave (Fully developed, real \omega)',...
%     'Crack wave (Fully developed, real k)',...
%     'location','southeast');

grid on;

line(M.wel./M.al*[1 1],ylim,'color','k','linewidth',1);
line([1 1],ylim,'color','k','linewidth',1);
set(gca,'XTick',10.^(log10(min(xll)):2:log10(max(xll))));
set(gca,'YTick',10.^([-4:0]));

xlabel('Frequency \omega/\alpha');

text(10.^-0.2,10^-1.0,'\omega=\alpha','rotation',90,'fontsize',24);
text(2.1*10.^3,10^-1.0,'\omega=\omega_{el}','rotation',90,'fontsize',24,'fontname','times');
title(10^4,10^-2,['\omega_{el}/\alpha = ' num2str(M.wel/M.al,2)],'fontsize',24,'fontname','times');

% Plot Attenuation
% axes(ha(2)); 
% subplot(2,1,2);
figure;

% loglog(XX,ones(size(Z0)),'--r'); 
loglog(XX,att,'-k','linewidth',3);hold on;
% loglog(XX,Z2,'--g');
loglog(XX,ZZZ,'--k');
loglog(XX,Z3,'--r');
% loglog(XX,Z0/3,'--m');
% loglog(XX,Z4,'--g');
% loglog(XX,att,'-k','linewidth',3);

% title(['\alpha = ' num2str(M.al,2) ', \omega_{el} = ' num2str(M.wel,2) 's^{-1}']);
xlabel('Frequency \omega/\alpha');
grid on;
ylim(yll);
xlim(xll);
ylabel('Spatial Attenuation, 1/2Q');

line(M.wel./M.al*[1 1],ylim,'color','k','linewidth',1);
line([1 1],ylim,'color','k','linewidth',1);
set(gca,'XTick',10.^(log10(min(xll)):2:log10(max(xll))));
set(gca,'YTick',10.^([-4 -2 0]));
legend('General solution','Fully Developed','Boundary Layer');
