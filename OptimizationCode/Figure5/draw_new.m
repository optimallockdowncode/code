% clear; 
a = 0.5;
loadStr = 'current_indiv_run.mat'; %'benchmark_fig1.mat';
% loadStr = sprintf('results_alpha_%i.mat',round(100*a));
% load(loadStr);

t = z.t;
S = z.s; IA = z.ia; IS = z.is; J = z.j; D = z.d; RA = z.ra; RS = z.rs;
Sq = z.sq; IAq = z.iaq; ISq = z.isq; Jq = z.jq; RAq = z.raq; RSq = z.rsq;
 tbar = z.tbar;  tsar = z.tsar; p = z.p; pq = z.pq;  LTs=z.lts; 
E=z.e;Eq=z.eq; N1=z.n1; Nq=z.nq; Ts1=z.ts1; Ts2=z.ts2; tbar=z.tbar; tsar=z.tsar; 
prod=z.wf;

Inf=IA+IS;
Infq=IAq+ISq;
EplusI=Inf+E;
EplusIq=Infq+Eq;

f = figure(322); clf; 
subplot(2,3,1);hold on;
yyaxis left
plot(t,S,'b','linewidth',2);
yyaxis right
plot(t,EplusI,'r','linewidth',2);
axis([0 T 0 0.3]);

TITLE = title('(A) Non-Quarantined Pop'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$S$','$E+I$'}); L.Interpreter = 'latex';
% L.FontSize = 14; %L.Location = 'east';
%axis([0 T 0 1]);


subplot(2,3,2); hold on;
yyaxis left
plot(t,Sq,'b','linewidth',2);
axis([0 T 0 1]);
yyaxis right
plot(t,EplusIq,'r','linewidth',2);
axis([0 T 0 0.3]);


TITLE = title('(B) Quarantined Pop'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$S_q$','$E_{q}+I_{q}$'}); L.Interpreter = 'latex';
%L.FontSize = 14; 
%axis([0 T 0 1]);

subplot(2,3,3); hold on;

yyaxis right
plot(t,Ts1,'r','linewidth',2);
axis([0 T 0 0.1]);
yyaxis left
% plot(t,0.01./(1+13.5*exp(-0.016*t)),'c','linewidth',2);
plot(t,Ts2,'b','linewidth',2);
axis([0 T 0 0.1]);
TITLE = title('(C) Testing of Pop'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$T_q$','$T$'}); L.Interpreter = 'latex';

subplot(2,3,4); hold on;

yyaxis right
plot(t,prod,'r','linewidth',2);
axis([0 T 0.5 1]);
yyaxis left
plot(t,D,'b','linewidth',2);
axis([0 T 0 0.005]);
TITLE2 = title('(D) GDP and Fatalities '); TITLE2.Interpreter = 'latex'; TITLE2.FontSize = 14;
TITLE2.Position(2) = 0.0054;
L = legend({'Deaths','Marginal $GDP$'}); L.Interpreter = 'latex';

subplot(2,3,5); hold on;

yyaxis right
plot(t,p,'r','linewidth',2);
axis([0 T 0 1]);
yyaxis left
plot(t,pq,'b','linewidth',2);
axis([0 T 0 1]);

TITLE = title('(E) Transition '); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'From Q','To Q'}); L.Interpreter = 'latex';

subplot(2,3,6); hold on;

yyaxis right
plot(t,tbar,'r','linewidth',2);
axis([0 T 0 0.1]);
yyaxis left
plot(t,tsar,'b','linewidth',2);
axis([0 T 0 0.1]);

TITLE = title('(F) Testing in Q vs NQ'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$test_q$','$test$'}); L.Interpreter = 'latex';
% L.FontSize = 14;
%axis([0 T 0 0.2]);


f.Units = 'Inches';
f.Position = [2 0.5 11 6];






%%%%%%% THIS PRINTS THE CURRENT FIGURE TO A .eps FILE
%%%%% CHANGE 'current_pic' TO WHATEVER YOU WANT THAT FILE NAMED
% FILENAME = 'fig3_revisions';
% print(FILENAME,'-depsc');