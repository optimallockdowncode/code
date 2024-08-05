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


