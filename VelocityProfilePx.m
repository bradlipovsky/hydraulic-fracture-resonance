% Plot the velocity response to a pressure perturbation
clear; tic;

CreateFracture;
omega = M.al*logspace(-5,5,75);

nx = 500;
y = linspace(0,w,nx);

iii=[30 40 50 60];
% iii = 1:75;
nind = numel(iii);


% nt = 11;
% time = linspace(0,0.5,nt)*pi;
nt = 1;
time = 0.5*pi;
% col = jet(nt);
col = [0 0 0];

figure;
for j = 1:nt
for i = 1:nind
    ii = iii(i);
    
    xi = sqrt(-1j*omega(ii)./M.al);
%     xi = (-1)^(3/4) * sqrt(omega(ii)./M.al);
% xi = 1 * sqrt(omega(ii)./M.al);
    
    p = exp(1j*time(j));

    Tp = -1j/omega(ii)/rhof*( 1 - (cosh(xi * y / w)/cosh(xi))  )';    
    Tpbl = -1j/omega(ii)/rhof*( 1 - exp( (y/w-1)*xi)  )';    
    Tpfdf = -1j/omega(ii)/rhof*( xi.^2/2 * (1 - (y/w).^2)  )';    
    
    vxp = real(Tp * p);
    vxpfdf = real(Tpfdf*p);
    vxpbl = real(Tpbl*p);
    
%     subplot(2,2,i); 
figure;
    plot(vxp(:,1),y,'linewidth',2,'color',col(j,:));  hold on;
    plot(vxp(:,1),-y,'linewidth',2,'color',col(j,:));  hold on;
%         plot(vxpfdf(:,j),y,'or','linewidth',2);  hold on;
%         plot(vxpbl(:,1),y,'o','color',col(j,:));  hold on;
%         plot(vxpbl(:,1),-y,'o','color',col(j,:));  hold on;
    title(['\omega/\alpha = ' num2str(omega(ii)./M.al,3)]);
%     ylim([min(y)-0.01 max(y)+0.1])
%     axis off;

end
end