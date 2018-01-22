clear;  pause on;    tic;


%
% Volcanos
%
% q_ob = [400 1000 40 40];
% f_ob = [8 3 1.5 6];

%
% Estimate length and width with lower viscosity magma
%
% CreateFracture_Basalt;
% L_Range = 2*pi*[10^4 10^-2];
% W_Range = [10^3 10^-2];
% figure; h = subplot(2,1,1);
% [L,W] = LW(L_Range,W_Range,q_ob,f_ob,M,h);
% xlim([0 3]);
% ylim([-2 2]);
% 
% CreateFracture_WaterRock;
% L_Range = 2*pi*[10^5 10^-2];
% W_Range = [10^2 10^-4];
% h = subplot(2,1,2);
% [L2,W2] = LW(L_Range,W_Range,q_ob,f_ob,M,h);
% xlim([0 3]);
% ylim([-4 1]);

% %
% % Andesitic magma
% %
% CreateFracture_Andesite;
% L_Range = 2*pi*[10^3 10^0];
% W_Range = [10^3 10^-1];
% h = subplot(2,1,2);
% [L2,W2] = LW(L_Range,W_Range,q_ob,f_ob,M,h);


% Glacier obs
CreateFracture_WaterTill;
% CreateFracture_WaterIce;
q_ob_ice = [500 3 1 30 3];
f_ob_ice = [75 3 1 75 6];
L_Range = 2*pi*[10^3 10^-2];
W_Range = [10^1 10^-4];
figure
h=subplot(1,1,1);
[L3,W3] = LW(L_Range,W_Range,q_ob_ice,f_ob_ice,M,h);
xlim([-1 2]);
ylim([-4 0]);

% Reservoir obs
% CreateFracture_WaterRock;
% q_ob_ice = [20	40];
% f_ob_ice = [115	17];
% L_Range = 2*pi*[10^2 10^-2];
% W_Range = [10^-2 10^-5];
% figure
% h=subplot(1,1,1);
% [L4,W4] = LW(L_Range,W_Range,q_ob_ice,f_ob_ice,M,h)
% xlim([-1 1]);
% ylim([-4.5 -2]);

% % Simulated Data
% CreateFracture_WaterRock2;
% q_ob_ice = 2.63;
% f_ob_ice = 5.25;
% L_Range = 2*pi*[10^3 10^-2];
% W_Range = [10^1 10^-4];
% figure
% h=subplot(1,1,1);
% [L3,W3] = LW(L_Range,W_Range,q_ob_ice,f_ob_ice,M,h);
% xlim([-1 2]);
% ylim([-4 0]);