function [L,W] = LW(L_Range,W_Range,q_ob,f_ob,M,h)

nk = 30;
nw = 40;

%
% 1.  Calculate the upper and lower bounds for the fundamental mode.
%

% The fundamental mode is lambda = 2*L
lambda_1 = 2 * L_Range(1);
lambda_2 = 2 * L_Range(2);

% k_i = 2 pi / lambda_i
logkmin = log10(2*pi/lambda_1);
logkmax = log10(2*pi/lambda_2);

logwmax = log10(W_Range(1));
logwmin = log10(W_Range(2));

k = logspace(logkmin,logkmax,nk);
wlist = logspace(logwmin,logwmax,nw);





%
% 2.  Calculate the complex frequency for each frequency/width pair using
%     the dispersion relation.
%
OM = zeros(nw,nk);
Q=OM;CP=OM;
for i = 1:nw
    w = wlist(i);
    M.wel = M.Kf*M.c0/M.Gp/w;
    M.al = M.nu/w^2;

    M.x = k;
    M.type='FixedWavenumber';
    
    omega = RootFinder(ProcVarArg(M));
    OM(i,:) = abs(real(omega(1,:)*M.c0 .* k)); 
    CP(i,:) = abs(real ( omega(1,:) ));
    Q(i,:) = abs(real(omega(1,:))./imag(omega(1,:))/2);
    toc
end

[KK,WW] = meshgrid(k,wlist);
F0 = OM/2/pi;   % Careful to convert between angular and seismic frequency.









%
% 3.  Make the plots.
%

%
% a.  Plot the Q/f1 contours
%
logL = log10(pi./KK);
logW = log10(WW);

QltOne = Q(:) < sqrt(3);
QQ_filt = Q;   QQ_filt(QltOne) = nan;
F0_filt = F0;   F0_filt(QltOne) = nan;


contour(h,logL,logW,log10(Q),1:5,'linecolor','k','linewidth',2);hold on;
contour(h,logL,logW,log10(F0),-2:4,'linewidth',2,'linecolor','r');hold on;



%
% b.  Plot the line where the wave cutoff occurs
%
C = contour(h,logL,logW,log10(Q),log10(sqrt(3)),'linecolor','none'); hold on;
nn = 10;
ckc = polyfit(C(1,nn:end-nn),C(2,nn:end-nn),1); % I don't know why endpoints are weird
plot(h,log10(2*pi./k),polyval(ckc,logL),'-w','linewidth',10);
plot(h,log10(2*pi./k),polyval(ckc,logL),'--k','linewidth',5);



%
% c.  Plot line where omega=omega_el in L/W space.
%
Lel = zeros(nw,1);
oelone = 0;

wel = M.Kf*M.c0/M.Gp./ wlist;
for i = 1:nw
    
    [~, oelind] = min(abs((OM(i,:) - wel(i))));
    Lel(i) = abs(pi/k(oelind));     % Fundamental mode

    if oelind == 1
        if oelone == 1
            Lel(i) = 0;    
        else 
            oelone = 1;
        end
    end
end

% Interpolate omega=omega_el lines. The lines appear jagged without this.
range = (Lel>0) & (Lel<1);
cel = polyfit(log10(Lel(range)),log10(wlist(range)'),1);
% plot(h,log10(Xel),cel(1).*log10(Xel) + cel(2),'--k','linewidth',5);
plot(h,log10(Lel),polyval(cel,log10(Lel)),'--k','linewidth',5);




%
% d.  Interpolate to plot the data.  
%
nobs = numel(q_ob);
col = jet(nobs);
L = zeros(nobs,1); W=L;


logWq = scatteredInterpolant(log10(Q(:)),log10(F0(:)),logW(:));
logLq = scatteredInterpolant(log10(Q(:)),log10(F0(:)),logL(:));

for i = 1:nobs
    L(i) = 10^logLq(log10(q_ob(i)),log10(f_ob(i)));
    W(i) = 10^logWq(log10(q_ob(i)),log10(f_ob(i)));

    % Put a dot on the chart to indicate an observation.
    plot(h,log10(L(i)),log10(W(i)),'ok','markerfacecolor',col(i,:),...
        'markersize',16);
end



%
% e.  Add nicer labels.
%
set(h,'xtick',-1:5);
set(h,'xticklabel',{'0.1','1','10','100','1,000','10,000','100,000'});
set(h,'ytick',-5:3);
set(h,'yticklabel',{'0.00001','0.0001','0.001','0.01','0.1','1','10','100','1,000'});
xlabel('Fracture Length (m)'); ylabel('Fracture Width (m)');