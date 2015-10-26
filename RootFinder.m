function [X, fval, ef] = RootFinder(M)
%
% RootFinder(M) finds roots of the function @M.D over a range of values of
% parameters.  The root finder exploits the continuity of the roots as
% functions of the parameters.
%
nr = 2;

ns=numel(M.x);
X = zeros(nr,ns); 
ef = X; fval = X;
sp= zeros(nr,2);
ThisFun = cell(nr,1);
HelpFun = cell(nr,1);
r = zeros(nr,2);
P=M;

neps = eps^2;
op = optimset('display','off','tolx',neps,'tolfun',neps);

% The actual root finder.
for j = 1:ns
    i = ns-j+1;
    P.L = M.L(i);
    P.Z = M.Z(i);
    P.xx=M.x(i);
    
    for g = 1:nr
        if g == 1
           HelpFun{1} = @(k) M.D(k(:,1), k(:,2), P);
        else
            % Divide the dispersion relation by any roots that have been
            % found.
            HelpFun{g} = @(k) HelpFun{g-1}(k)./(k(:,1)+1j*k(:,2)-X(g-1,i));
        end
        % Find the zeros of the imaginary part and real part of D
        % seperately.
        ThisFun{g} = @(k) [real(HelpFun{g}(k)), imag(HelpFun{g}(k))];

        % Continuation:  start at the last known root.
        if j > 1    
            sp(g,:) = [r(g,1), r(g,2)];
%             sp(g,:) = r(g,:);
        else
            sp(g,:) = M.sp0(g,:);
        end

        % Run fsolve to find the root
        try
            [r(g,:), fv, ef(g,i)] = fsolve(ThisFun{g},sp(g,:),op);
        catch ermg
            disp(ermg.message);
        end
        
        fval(g,i) = fv(1) + 1j * fv(2);
        X(g,i) = r(g,1) + 1j * r(g,2);

        if isfield (M,'display')
            if (g==nr) && M.display
                PlotContoursTwo
            end
        end
    end
end
