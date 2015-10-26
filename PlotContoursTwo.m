figure(1);  clf;
facx = 4;
facy = facx;

RootNumberList = 1:nr;
for RootNumber = RootNumberList;

    subplot(1,numel(RootNumberList),RootNumber-min(RootNumberList)+1); 
    set(gca,'fontsize',20);
    
    ng = 1500;
    %     m = max(abs(X(RootNumber,i)));
        m = 1;
%     m = (M.x(i)/M.wel) ^ (1/3);

    [Xr, Xi] = meshgrid(linspace(-facx*m,facx*m,ng),...
        linspace(-facy*m,facy*m));

    VectorX = ThisFun{RootNumber}([Xr(:),Xi(:)]);
    ComplexD = VectorX(:,1) + 1j*VectorX(:,2);
    D = reshape(ComplexD,size(Xr));

    contourf(Xr,Xi,log10(abs(D)),50,'linecolor','none'); hold on;
    title(['|D|, \omega = 10^{' num2str(log10(M.x(i)),2) '}']);

    plot(X(RootNumber,i), 'ok','markerfacecolor','r','markersize',12);
    plot(sp(RootNumber,1),sp(RootNumber,2),'ok','markerfacecolor','w');
    colorbar;
    xlim(facx*[-1 1]); ylim(facy*[-1 1]);
%     caxis([0 15]);
end

disp (['Step ' num2str(i) ', EF = ' num2str(ef(g,i))]);
disp (['  log10(s) = ' num2str(log10(M.x(i)),2)]);
disp (['  log10(L) = ' num2str(log10(M.L(i)),2)]);
disp (['  log10(Z) = ' num2str(log10(M.Z(i)),2)]);
disp (['  log10(|X|) = ' num2str(log10(abs(X(g,i))),2)]);
pause(1);