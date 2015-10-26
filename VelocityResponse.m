% Plot the velocity response to a pressure perturbation
clear; tic;

CreateFracture;
omega = M.al*logspace(-5,5,75);
M.x = omega;
M.type='FixedFrequency';
[K, fval, ef] = RootFinder(ProcVarArg(M)); toc;

y = linspace(-w,w,10000);
% y = linspace(0.98,1,10000);
nt = 8;
% iii = [5 25 30];
% iii = [30 31 32];
iii=[20 60];
mdc = bone(nt);

figure; 
% ha = tight_subplot(4,1,0.03,[0.0 0.05],[0.1 0.01]);

for i = 1:2
    ii = iii(i);
    
    k = K(1,ii);
%     t = linspace(0,1,nt)*pi/omega(ii);
    t = pi; nt = 1;
    xi = sqrt(-1j* omega(ii)./M.al);
    
    p = exp(1j*omega(ii)*t);
%     p = dirac(t);
    
%     N = 1/2 * ( exp(xi * y / w) + exp(-xi * y / w) );
%     D = 1/2 * ( exp(xi) + exp(-xi) );
    
    N = exp(xi * y / w) + exp(-xi * y / w);
    D = exp(xi) + exp(-xi);
    
    Tbl =  -k/omega(ii)/rhof*( (N/D - 1)  )';
    Tp = -k/omega(ii)/rhof*( (cosh(xi * y / w)/cosh(xi) - 1)  )';
    
    vxp = real(Tp) * real(p) + imag(Tp) * imag(p);
    vbl = real(Tbl) * real(p) + imag(Tbl) * imag(p);
    
%     axes(ha(i));
    subplot(3,1,i);
    
    for j = 1:nt
        plot(vxp(:,j),y,'linewidth',4,'color','k'); hold on;
        plot(vxp(:,j),y,'linewidth',2,'color',mdc(j,:)); hold on;
%         plot(vbl(:,j),y,'o','linewidth',2,'color',mdc(j,:)); hold on;
    end

%     text(-1,0.925,['\omega/\alpha = ' num2str(omega(ii)./M.al,3)],...
%         'FontSize',18,'FontName','Times');
    title(['\omega/\alpha = ' num2str(omega(ii)./M.al,3)]);
%     
%     if i == 2
%         ylabel('Conduit Width w/w_0');
%     end
%     
    ylim([min(y) max(y)])
% %     xlim([-1.1 1.1]);
%     
%     if i==3
%         xlabel('Perturbation Velocity, \delta v_x / u_{BL}');
%     else
% %         set(gca,'XTick',[]);
%     end
    
end

% axes(ha(4));
subplot(3,1,3);
caxis([0 1]);
colormap(mdc);
cb=colorbar('location','northoutside'); 
xlabel(cb,'Phase / (2\pi)');
axis off;