function P = ProcVarArg(M)
% Sets defaults so I don't have to.

P = M;

%
% This part sets defaults
%
if ~isfield(M,'thet')
    P.thet = 0;
end

if ~isfield(M,'ed')
    P.ed = 0;
end

if isfield (M,'turb')
    if M.turb
        P.m=1;
        P.n=4/3;
        P.fdf = true;
    else
        P.m=4;
        P.n=0;
    end
else
    P.m=4;
	P.n=0;
end


%
% The parameters Z and L depend on the normalization.
%
if strcmpi(M.type,'fixedfrequency')
    P.D = @dif;
    P.Z = M.al./M.x;
    if isfield (M,'fdf')
        if M.fdf, P.f=ones(size(P.Z));  end
    end
    P.L = M.wel./M.x;
    
    P.sp0(1,:)=[1 (M.x(end)).^-1];
    P.sp0(2,:)=[-1 -(M.x(end)).^-1];
%     P.sp0(3,:)=[-(M.x(end)).^-1 1];
    P.sp0(3,:)=eps*[1 1];
    P.sp0(4,:)=-eps*[1 1];
    P.sp0(5,:)=-[1 1];
    
elseif strcmpi(M.type,'fixedwavenumber')
    P.D = @dik;
    P.Z = M.al./M.x/M.c0;
    P.L = M.wel./abs(M.x)/M.c0;
    
    P.fdf = 0;
    if isfield (M,'fdf')
        if M.fdf, P.fdf=M.fdf;  end
    end
    
    
    P.sp0(1,:)=[(M.x(end)).^-1 1];
    P.sp0(2,:)=[-(M.x(end)).^-1 -1 ];
end