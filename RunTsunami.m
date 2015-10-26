clear; pause on;
nx = 1000;
x = linspace(0,10000,nx);
nt = 100;
t = linspace(0,100,nt);
source = zeros(size(x));
source(500)=1;
z = zeros(nt,nx);

for tt = 1:nt
    z(tt,:) = tsunami_wave(x,t(tt),source,9.8,100);
end

m = max(abs(z(:)));

for tt = 1:nt
    plot(x,real(z(tt,:)));
    ylim(m*[-1 1]);
    pause(0.1);
end