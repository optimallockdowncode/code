%%for plot of Q against m and Lzero (logistic params)
clear; close all;
load Q13d_new.mat
%load Q_vs_tau_vs_VSL.mat
%%
figure(216);clf;hold on;
[x,y] = ndgrid(vals1,vals2);
surf(x,y,totalQ); colorbar; 
TI = title(sprintf('Total Quarantine (Person Days)')); TI.Interpreter = 'latex'; TI.FontSize = 16;
XL = xlabel(sprintf('$%s$',INDEP_VARIABLE1)); XL.Interpreter = 'latex'; XL.FontSize = 14; %XL.Rotation = 0; XL.Position(1) = 0.06; XL.Position(2) = -6;
YL = ylabel(sprintf('$%s$',INDEP_VARIABLE2)); YL.Interpreter = 'latex'; YL.FontSize = 14;
axis([min(vals1) max(vals1) min(vals2) max(vals2)]);
% colormap summer;
colormap default;
% view([90,90]);
colorbar;
view([45 50]);

%vals = vals1;
%totalQ = totalQ(:,vals2==40)';
%figure(311);clf; hold on;
%plot(vals,totalQ,'b','linewidth',2);
%TI = title(sprintf('Total Quarantine vs. $%s$',INDEP_VARIABLE1)); TI.Interpreter = 'latex'; TI.FontSize = 16;
%XL = xlabel(sprintf('$%s$',INDEP_VARIABLE1)); XL.Interpreter = 'latex'; XL.FontSize = 14;
%YL = ylabel('Total Person-Days of Quarantine'); YL.Interpreter = 'latex'; YL.FontSize = 14;