clear; tic; figure;

nk=100;

%
% Basalt
%
CreateFracture_Basalt;
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);

k = logspace(log10(kc),1,nk);
M.x = k;
M.type='FixedWavenumber';
omega = RootFinder(ProcVarArg(M));
OM = abs(real(omega(1,:)*M.c0 .* k)); 
CP = abs(real ( omega(1,:) ));
LL = CP./OM/2/pi * c0; % dimensional wavelength

M_0 = linspace(4,12,10);
[MM, L] = meshgrid(M_0,LL);
[~, F] = meshgrid(M_0,OM/2/pi);
dp = 10.^MM .* L.^-3;


subplot(2,1,1);
% contour(MM,log10(F),log10(dp),-4:2:18,'linecolor','k','ShowText','on');
contour(MM,log10(F),log10(dp),-4:2:18,'linecolor','k');


title('Basalt Melt in Rock');
xlabel('Moment, M_0 (N m)');
ylabel('Characteristic Frequency, f_0 (Hz)');
set(gca,'ytick',-2:2);
set(gca,'yticklabel',{'0.01','0.1','1','10','100'});
% set(gca,'xtick',6:2:14);
ylim([-2.5 2]);
toc
















%
% Water in Ice
%
CreateFracture_WaterIce;
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);

k = logspace(log10(kc/2),3,nk);
M.x = k;
M.type='FixedWavenumber';
omega = RootFinder(ProcVarArg(M));
OM = abs(real(omega(1,:)*M.c0 .* k)); 
CP = abs(real ( omega(1,:) ));
LL = CP./OM/2/pi * c0; % dimensional wavelength

M_0 = linspace(0,8,10);
[MM, L] = meshgrid(M_0,LL);
[~, F] = meshgrid(M_0,OM/2/pi);
dp = 10.^MM .* L.^-3;


subplot(2,1,2);
% contour(MM,log10(F),log10(dp),-4:2:16,'linecolor','k','ShowText','on');
contour(MM,log10(F),log10(dp),-4:2:16,'linecolor','k');


title('Water in Ice');
xlabel('Moment, M_0 (N m)');
ylabel('Characteristic Frequency, f_0 (Hz)');
set(gca,'ytick',-2:3);
set(gca,'yticklabel',{'0.01','0.1','1','10','100','1,000','10,000'});
ylim([-0.5 2.5]);
% set(gca,'xtick',6:2:14);
toc









% %
% % Water in Rock
% %
% CreateFracture_WaterRock;
% kel = Kf/Gp./w;
% al = nu./w.^2;
% kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);
% 
% nk=100;
% k = logspace(log10(kc/2),3,nk);
% M.x = k;
% M.type='FixedWavenumber';
% omega = RootFinder(ProcVarArg(M));
% OM = abs(real(omega(1,:)*M.c0 .* k)); 
% CP = abs(real ( omega(1,:) ));
% Q = abs(real(omega(1,:))./imag(omega(1,:))/2);
% LL = CP./OM/2/pi * c0; % dimensional wavelength
% 
% [MM, L] = meshgrid(M_0,LL);
% [~, F] = meshgrid(M_0,OM/2/pi);
% dp = 10.^MM .* L.^-3;
% 
% 
% subplot(3,1,3);
% contour(MM,log10(F),log10(dp),-4:2:16,'linecolor','k','ShowText','on');
% % contour(MM,log10(F),log10(dp),-4:2:16,'linecolor','k');
% 
% 
% title('Water in Rock');
% xlabel('Moment, M_0 (N m)');
% ylabel('Characteristic Frequency, f_0 (Hz)');
% set(gca,'ytick',-2:3);
% set(gca,'yticklabel',{'0.01','0.1','1','10','100','1000'});
% ylim([0 3]);
% % set(gca,'xtick',6:2:14);
% toc