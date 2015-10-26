clear;  pause on;    tic;


CreateFracture;

M.x = omega;
M.type='FixedFrequency';
[K, fval, ef] = RootFinder(ProcVarArg(M)); toc;






%
% Calculate fields
%
rt = 2;
% att = abs ( imag(K(rt,:))./real(K(rt,:)) );
att = imag(K(rt,:))./real(K(rt,:));
cp =  abs ( 1./real(K(rt,:)) );

zeta = 2/3* M.al ./ omega;
L = M.wel ./ omega;

% X1 = omega/M.wel;
X1 = omega/M.al;

cpzcw = (zeta.*L).^(-1/3) / 2^(1/3);
cpbsw = sqrt(omega./M.al);
cpcw = (omega./M.wel).^(1/3);
cpdcwk = (omega.^3/M.wel/M.al^2).^(1/3);

%
% Plot Phase Velocity
%

figure(1);
loglog(X1,cp,'-k','linewidth',3); hold on;
loglog(X1,ones(size(cp)),'--k');
loglog(X1,cpbsw,'--m');
loglog(X1,cpcw,'--b');
loglog(X1,cpzcw,'--g');
loglog(X1,cpdcwk,'--r');
loglog(X1,cp,'-k','linewidth',3); hold on;


title(['\alpha = ' num2str(M.al,2) 's^{-1}, \omega_{el} = ' num2str(M.wel,2) 's^{-1}']);
% xlabel('Frequency \omega/\omega_{el}');
grid on;
ylim([10^-3 2]);
xlim([10.^-8 10^3]);
ylabel('Phase Velocity, c/c_0');

legend('General solution','Undamped sound wave','Damped sound wave',...
    'Undamped crack wave','Damped crack wave (constant \omega)',...
    'Damped crack wave (constant k)',...
    'location','southeast');
grid on;
% line(M.al./M.wel*[1 1],ylim,'color','k','linewidth',1);
line(M.wel./M.al*[1 1],ylim,'color','k','linewidth',1);
line([1 1],ylim,'color','k','linewidth',1);
set(gca,'XTick',10.^(-8:2:6));



%
% Plot 1/Q
%
figure(2);
rt=1;
att = 2*imag(K(rt,:))./real(K(rt,:));
Z0 = M.al./omega;
xi = sqrt(-1j./(Z0));
Z2 = Z0.*real(xi)/3;
L = M.wel./omega;
XX = omega/ ( M.al );
loglog(XX,ones(size(Z0)),'--r'); hold on;
loglog(XX,Z0,'--m');
loglog(XX,Z2,'--b');
loglog(XX,att,'-k','linewidth',3);
% loglog(XX,1-att,'-k','linewidth',1);

title(['\alpha = ' num2str(M.al,2) ', \omega_{el} = ' num2str(M.wel,2) 's^{-1}']);
xlabel('Frequency \omega/\alpha');
grid on;
ylim([10^-3  2]);
% xlim([10.^-3 10^3]);
ylabel('Attenuation, 1/Q');

line(M.wel./M.al*[1 1],ylim,'color','k','linewidth',1);




%
% Group Velocity
%
littleK = real(K(rt,:)) / c0 .* omega;
cg = abs(   diff(omega)./diff(littleK)/c0   );
figure;
loglog(omega(2:end),cg); hold on;
loglog(omega,cp,'-r');
