% Plot the velocity response to a pressure perturbation
clear; tic;

CreateFracture;
omega = M.al*logspace(-5,5,75);
% M.x = omega;
% M.type='FixedFrequency';
% [K, fval, ef] = RootFinder(ProcVarArg(M)); toc;

nx = 50;
y = linspace(0,w,nx);

iii=[30 35 38 40 45 50];
% iii = 1:75;
nind = numel(iii);

figure;
for i = 1:nind
    ii = iii(i);
    
%     k = K(1,ii) .* omega(ii) ./ c0;
    t = 0/omega(ii);
    nt = numel(t);
    xi = (-1)^(3/4) * sqrt(omega(ii)./M.al);
    
    p = exp(1j*omega(ii)*t);

%     N = 1/2 * ( exp(xi * y / w) + exp(-xi * y / w) );
%     D = 1/2 * ( exp(xi) + exp(-xi) );
    
%     N = exp(xi * y / w) + exp(-xi * y / w);
%     D = exp(xi) + exp(-xi);
    
%     Tbl =  -k/omega(ii)/rhof*( (N/D - 1)  )';
%     vbl = real(Tbl) * real(p) + imag(Tbl) * imag(p);

%
% xfer fcns bt u and p
%
%     Tp = k/omega(ii)/rhof*( 1 - (cosh(xi * y / w)/cosh(xi))  )';    
%     Tpbl = k/omega(ii)/rhof*( 1 - exp( (y/w-1)*xi)  )';    
%     Tpfdf = k/omega(ii)/rhof*( xi.^2/2 * (1 - (y/w).^2)  )';    

%
% xfer fcns bt u and px
%
    Tp = -1j/omega(ii)/rhof*( 1 - (cosh(xi * y / w)/cosh(xi))  )';    
    Tpbl = -1j/omega(ii)/rhof*( 1 - exp( (y/w-1)*xi)  )';    
    Tpfdf = -1j/omega(ii)/rhof*( xi.^2/2 * (1 - (y/w).^2)  )';    
    
    %     vxp = real(Tp) * real(p) + imag(Tp) * imag(p);
    vxp = real(Tp * p);
    vxpfdf = real(Tpfdf*p);
    vxpbl = real(Tpbl*p);
    
    subplot(nind,1,i);
    for j = 1:nt
        plot(vxp(:,j),y,'-k','linewidth',2);  hold on;
%         plot(vxpfdf(:,j),y,'or','linewidth',2);  hold on;
%         plot(vxpbl(:,j),y,'ob','linewidth',2);  hold on;
    end
    title(['\omega/\alpha = ' num2str(omega(ii)./M.al,3)]);
    ylim([min(y)-0.01 max(y)+0.1])
%     axis off;

end