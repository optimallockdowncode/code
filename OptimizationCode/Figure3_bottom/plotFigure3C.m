%%for plot of Q against b1 and VSL (only works after running driver_fig3C
clear; close all;
load current.mat
%%
figure(216);clf;hold on;
[x,y] = ndgrid(vals1,vals2);
surf(x,y,totalQ); colorbar; 
TI = title(sprintf('Total Quarantine (Person Days)')); TI.Interpreter = 'latex'; TI.FontSize = 16;
XL = xlabel(sprintf('$VSL$')); XL.Interpreter = 'latex'; XL.FontSize = 14; %XL.Rotation = 0; XL.Position(1) = 0.06; XL.Position(2) = -6;
YL = ylabel(sprintf('$%s$',INDEP_VARIABLE2)); YL.Interpreter = 'latex'; YL.FontSize = 14;
axis([min(vals1) max(vals1) min(vals2) max(vals2)]);
colormap default;
colorbar;
view([0,90]);
