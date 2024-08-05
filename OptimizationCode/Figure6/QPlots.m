%% for plots of Q against different indiv. variables (alpha, rho, theta)
clear; close all;
%load current.mat;
load current.mat; 
figure(311);clf; hold on;
plot(vals,totalQ,'b','linewidth',2);
TI = title(sprintf('Total Quarantine vs. $%s$',INDEP_VARIABLE)); TI.Interpreter = 'latex'; TI.FontSize = 16;
XL = xlabel(sprintf('$%s$',INDEP_VARIABLE)); XL.Interpreter = 'latex'; XL.FontSize = 14;
YL = ylabel('Quarantine (Person Days)'); YL.Interpreter = 'latex'; YL.FontSize = 14;
% axis([15 150 0 200])

%% for plot of Q against m and Lzero (logistic params)
% clear;
% load Q_vs_m_Lzero.mat
% figure(216);clf;hold on;
% [m,Lz] = ndgrid(vals1,vals2);
% surf(m,Lz,totalQ); colorbar; 
% view([90,90]);
% TI = title(sprintf('Total Quarantine (Person Days)')); TI.Interpreter = 'latex'; TI.FontSize = 16;
% XL = xlabel(sprintf('$%s$',INDEP_VARIABLE_NAME1)); XL.Interpreter = 'latex'; XL.FontSize = 14; XL.Rotation = 0; XL.Position(1) = 0.06; XL.Position(2) = -6;
% YL = ylabel(sprintf('$L_0$')); YL.Interpreter = 'latex'; YL.FontSize = 14;
% axis([min(vals1) max(vals1) min(vals2) max(vals2)]);

