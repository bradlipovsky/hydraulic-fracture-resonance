% Plot the velocity response to a pressure perturbation
clear;  pause on;    tic;


% Rock (assume poi=0.25)
rhor = 2700;
% cpr = 5000;
cpr = 2000;
poi = 0.25;
Gp  = cpr^2/3 * rhor / (1-poi);
Gpp = cpr^2/3 * rhor / (1-2*poi);

% Magma
rhof = 2500;
% c0 = 1000;
c0 = 2000;
Kf = c0^2 * rhof;  
mu = 10;
nu = mu/rhof;

% % Steam
% rhof = 10;
% c0 = 600;
% Kf = c0^2 * rhof;
% mu = 10^-5;
% nu = mu/rhof;

w = 1;
omega  = logspace(-5,10,50);

M.c0 = c0;
M.wel = Kf*c0/Gp/w;
M.al = 3/2*nu/w^2;
M.R = Kf / Gpp;

M.display=0;
M.x = omega;
M.type='FixedFrequency';
[K, fval, ef] = RootFinder(ProcVarArg(M)); toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ii = 29;
rt = 1;
Ki = K(rt,ii);
xi = w*sqrt(-1j*omega(ii)/nu);

y = linspace(0,1,500);
nt = 200;
t = linspace(0,1,nt)*4*pi/omega(ii);
% mdc = hsv(nt);

% Tp =  -( (cosh(xi * y / w0)/cosh(xi) - 1)  )';
Tp = Ki .* (1 - (1 - M.R.*Ki.^-2).*cosh(xi * y / w)./cosh(xi))';
vxp = real(Tp) * cos(omega(ii)*t) + imag(Tp) * sin(omega(ii)*t);
vxp = vxp./max(vxp(:));

% F(nt) = struct('cdata',[],'colormap',[]);
figure;
for j = 1:nt
%     plot(vxp(:,j),y,'linewidth',2,'color',mdc(j,:));
    hold off;
    plot(vxp(:,j),y); hold on;
    plot(vxp(:,j),-y);
    xlim([-1.1 1.1]);
    xlabel('Perturbation Velocity, \delta v_x / v_*');
    ylabel('Conduit Width w/w_0');
    ylim([-2 2]);
    line([-1.1 1.1],[1 1],'color','k');
    line([-1.1 1.1],-[1 1],'color','k');
%     F(j) = getframe;
    pause(0.1);
end
% hf = figure;movie(hf,F,4,30);
% movie2avi(F, 'Movie_BL.avi', 'compression', 'None');