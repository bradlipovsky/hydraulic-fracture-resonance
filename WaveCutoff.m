clear;  pause on;    tic;


CreateFracture_Andesite;
nw = 100;
w = logspace(-3,1,nw);
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);
plot(log10(w),log10(2*pi./kc),'-g'); hold on;

CreateFracture_Basalt;
nw = 100;
w = logspace(-3,1,nw);
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 15/8 * kel .* al.^2/c0^2 ) .^(1/3);
plot(log10(w),log10(2*pi./kc),'-r'); hold on;

CreateFracture_WaterIce;
nw = 100;
w = logspace(-3,1,nw);
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);
plot(log10(w),log10(2*pi./kc),'-b');

CreateFracture_WaterRock;
nw = 100;
w = logspace(-3,1,nw);
kel = Kf/Gp./w;
al = nu./w.^2;
kc = ( 9/4 * kel .* al.^2/c0^2 ) .^(1/3);
plot(log10(w),log10(2*pi./kc),'-k');

%
% Add nicer labels
%
set(gca,'ytick',-1:5);
set(gca,'yticklabel',{'0.1','1','10','100','1000','10000','100000'});
set(gca,'xtick',-5:3);
set(gca,'xticklabel',{'0.00001','0.0001','0.001','0.01','0.1','1','10','100','1000'});
xlabel('Fracture Width (m)'); ylabel('Cutoff Wavelength (m)');

ylim([-1 5]);

legend('Andesite Magma in Rock','Basalt Magma in Rock','Water in Ice','Water in Rock','location','southeast');
grid on;