clear;  pause on;    tic;

q_ob = [500 100 40 4];
f_ob = [8 3 1 20];
nobs = numel(q_ob);

CreateFracture_Basalt;
% CreateFracture_Andesite;
% CreateFracture_WaterRock;
% CreateFracture_WaterIce;

nk=50;
k = logspace(-3,1,nk);
nw = 50;
wlist = logspace(-2,2,nw);

OM = zeros(nw,nk);Q=OM;CP=OM;

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

[k0,WW] = meshgrid(k,wlist);




%
% Plot it.
%
figure;
attt = abs(1./Q/2);
QQ = Q;
QQ(log10(attt)>2) = nan;

F0 = OM;
F0(log10(abs(OM))<-3) = 0;

logL = log10(2*pi./k0);
logW = log10(WW);

contour(logL,logW,log10(QQ),0:4,'linecolor','k','linewidth',2);hold on;
contour(logL,logW,log10(F0),-1:4,'linewidth',2,'linecolor','r');



%
% Plot lines of where omega=omega_el and omega=alpha
%
Xel = zeros(nw,1);  Xal = Xel; 
oelone = 0; alone = 0;

for i = 1:nw
    wel = Kf*c0/Gp/ wlist(i);
    lel = Kf/Gp/ wlist(i);
    al = nu/wlist(i)^2;
    kel = 1/lel;
    kc = ( kel * (3*al/2/c0)^2 )^(1/3);

    [~, oelind] = min(abs((OM(i,:) - wel)));
    [~, alind]  = min(abs((OM(i,:) - al )));

    Xel(i) = abs(2*pi/k0(i,oelind));
    Xal(i) = abs(2*pi/k0(i,alind));

    % Throw out points that fall outside of the figure's boundaries.  Keep
    % one point on the boundary.
    if oelind == 1
        if oelone == 1
            Xel(i) = 0;    
        else 
            oelone = 1;
        end
    end
    if alind == 1; 
        if alone == 1
            Xal(i) = 0;    
        else 
            alone = 1;
        end
    end
end

% Interpolate the omega=omega_el and omega=alpha lines.  Because they are 
% located on a grid, the lines appear jagged without this step.
cel = polyfit(log10(Xel(Xel>0)),log10(wlist(Xel>0)'),1);
cal = polyfit(log10(Xal(Xal>0)),log10(wlist(Xal>0)'),1);
plot(log10(Xal),cal(1).*log10(Xal) + cal(2),'-w','linewidth',10);
plot(log10(Xel),cel(1).*log10(Xel) + cel(2),'--k','linewidth',5);
plot(log10(Xal),cal(1).*log10(Xal) + cal(2),'--k','linewidth',5);


%
% Goal:  Put a dot on the chart to indicate an observation.
%   This is a minimization problem.
col = jet(nobs);
for i = 1:nobs
    logWq = griddata(Q,F0,logW,q_ob(i),f_ob(i));
    logLq = griddata(Q,F0,logL,q_ob(i),f_ob(i));
%     [~,ind] = min(  abs(Q(:) - q_ob(i)) + abs(F0(:) - f_ob(i))  );
%     disp([num2str(10^(logL(ind))) ', ' num2str(10^(logW(ind)))]);
%     plot(logL(ind),logW(ind),'ok','markerfacecolor',col(i,:),...
%         'markersize',16);
    disp([num2str(10^(logLq)) ', ' num2str(10^(logWq))]);
    plot(logLq,logWq,'ok','markerfacecolor',col(i,:),...
        'markersize',16);
end

%
% Add nicer labels
%
set(gca,'xtick',0:3);
set(gca,'xticklabel',{'1','10','100','1000'});
set(gca,'ytick',-2:2);
set(gca,'yticklabel',{'0.01','0.1','1','10','100'});
xlabel('Fracture Length (m)'); ylabel('Fraceture Width (m)');