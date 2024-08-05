%% Figure 2A

load b1vsl40faster.mat
Q40f=totalQ;
load b1vsl40.mat
Q40=totalQ;
load b1vsl80faster.mat
Q80f=totalQ;
load b1vsl80.mat
Q80=totalQ;
b1=vals;

f = figure(313); clf; 
subplot(1,2,1);hold on;
%yyaxis left
plot(b1,Q40,'b','linewidth',2);
plot(b1,Q40f,'b+-','linewidth',2);
ylabel('Quarantine (Person Days)');
xlabel('$b_1$');
axis([0.01 0.1 40 80]);

TITLE = title('(A) VSL=40'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$Slow$','$Fast$'}); L.Interpreter = 'latex'; L.FontSize = 15;
ax = gca; ax.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';

subplot(1,2,2);hold on;
plot(b1,Q80,'k','linewidth',2);
plot(b1,Q80f,'k+-','linewidth',2);
axis([0.01 0.1 40 180]);
ylabel('Quarantine (Person Days)');
xlabel('$b_1$');

TITLE = title('(B) VSL=80'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$Slow$','$Fast$'}); L.Interpreter = 'latex';
L.FontSize = 15;
ax = gca; ax.FontSize = 15;
ax.TickLabelInterpreter = 'latex';
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';

f.Units = 'Inches';
f.Position = [1 1 12 5];

print('fig2AB_revisions','-depsc');