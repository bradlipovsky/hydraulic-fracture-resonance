clear; hold off;
nt = 20;
ny = 1000;

omega = 1;
al = 0.0001;

t = linspace(0,8*pi,nt);
f = -cos(omega*t);
y = linspace(1 - 2*sqrt(al),1,ny);
g = erf( (1 - y)' * (al*t).^(-1/2) );
% g = 2*pi*erf( (1 - y)' * (al*t).^(-1/2) ) - 1;

v = zeros(ny,nt);
for i = 1:ny
    temp = conv (f,g(i,:));
    v(i,:) = temp(1:nt);
end


mdc = jet(nt);
for i = 1:nt
    plot(v(:,i),y,'color',mdc(i,:)); hold on;
end
colormap(jet);
ylim([y(1) y(end)]);
colorbar;