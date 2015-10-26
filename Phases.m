clear;  pause on;    tic;

CreateFracture;
M.x = omega;
M.type='FixedFrequency';

K = RootFinder(ProcVarArg(M)); toc;
ind = 1;
s = sign(real(K(ind,:)));
Ks = s.*K(ind,:) .*omega/c0;
% Ks = abs(K(ind,:));
Z0 = M.al./omega;
xi = sqrt(-1j./Z0);
T = tanh(xi)./xi;

% % Pressure-width tf
% Twp = 1/Gp./Ks;
% Pwp = atan2(imag(Twp),real(Twp)) / pi/2;

% % Pressure to velocity
% Tup = K(ind,:)/c0/rhof.*(1 - T);
% Pup = atan2(imag(Tup),real(Tup)) / pi/2;

% Pressure gradient to velocity
Tup = 1./omega/c0/rhof.*(1 - T);
Pup = atan2(imag(Tup),real(Tup)) / pi/2;

figure(1);
X = omega/M.al;
[AX,H1,H2] =  plotyy(X,log10(abs(Tup)),X,Pup,@semilogx); hold on;
% [AX,H1,H2] = plotyy(X,log10(abs(Twp)),X,Pwp,@semilogx);

set(get(AX(1),'Ylabel'),'String','log_{10}[Amplitude (m/s)]') 
set(get(AX(1),'Ylabel'),'Color','k');
set(get(AX(1),'Ylabel'),'FontSize',25);
set(get(AX(1),'Ylabel'),'FontName','Times');
set(AX(1),'ycolor','k');

set(get(AX(2),'Ylabel'),'String','Phase (rad/(2\pi)');
set(get(AX(2),'Ylabel'),'Color','k');
set(get(AX(2),'Ylabel'),'FontSize',25);
set(get(AX(2),'Ylabel'),'FontName','Times');
set(AX(2),'ycolor','k');

set(H1,'LineStyle','-'); set(H1,'Color','k');
set(H2,'LineStyle','--'); set(H2,'Color','k');

yl=ylim; hold on;
line([1 1],ylim,'linewidth',1,'color','k');
line(M.wel/M.al*[1 1],ylim,'linewidth',1,'color','k');

grid on;
xlabel ('Frequency \omega/\alpha');