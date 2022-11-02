clear; 
a = 0.5;
loadStr = 'current_indiv_run.mat'; %'benchmark_fig1.mat';
% loadStr = sprintf('results_alpha_%i.mat',round(100*a));
load(loadStr);

t = z.t;
S = z.s; IA = z.ia; IS = z.is; J = z.j; D = z.d; RA = z.ra; RS = z.rs;
Sq = z.sq; IAq = z.iaq; ISq = z.isq; Jq = z.jq; RAq = z.raq; RSq = z.rsq;
mu = z.mu; tbar = z.tbar; p = z.p; pq = z.pq; LTr=z.ltr; LTs=z.lts; 
E=z.e;Eq=z.eq; N1=z.n1; Nq=z.nq; 


Inf=IA+IS;
Infq=IAq+ISq;
EplusI=Inf+E;
EplusIq=Infq+Eq;

f = figure(312); clf; 
subplot(1,3,1);hold on;
yyaxis left
plot(t,S,'b','linewidth',2);
plot(t,RA+RS,'k','linewidth',2);
yyaxis right
plot(t,EplusI,'r','linewidth',2);
axis([0 T 0 0.3]);

TITLE = title('(A) Non-Quarantined Pop'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$S$','$R$','$E+I$'}); L.Interpreter = 'latex';
% L.FontSize = 14; %L.Location = 'east';
%axis([0 T 0 1]);


subplot(1,3,2); hold on;
yyaxis left
plot(t,Sq,'b','linewidth',2);
axis([0 T 0 1]);
yyaxis right
plot(t,EplusIq,'r','linewidth',2);
axis([0 T 0 0.3]);


TITLE = title('(B) Quarantined Pop'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$S_q$','$E_{q}+I_{q}$','$I_{S,q}$','$J_q$','$R_q$'}); L.Interpreter = 'latex';
%L.FontSize = 14; 
%axis([0 T 0 1]);




subplot(1,3,3); hold on;

yyaxis left
plot(t,tbar,'b','linewidth',2);
axis([0 T 0 0.05]);
yyaxis right
plot(t,mu,'r','linewidth',2);
axis([0 T 0 0.6]);
TITLE = title('(C) Testing and Tracing'); TITLE.Interpreter = 'latex'; TITLE.FontSize = 14;
L = legend({'$\overline{t}$','$\mu$',}); L.Interpreter = 'latex';
% L.FontSize = 14;
%axis([0 T 0 0.2]);
f.Units = 'Inches';
f.Position = [1 3 12 4];


%%%%%%% THIS PRINTS THE CURRENT FIGURE TO A .eps FILE
%%%%% CHANGE 'current_pic' TO WHATEVER YOU WANT THAT FILE NAMED
FILENAME = 'current_pic';
print(FILENAME,'-depsc');


% f2 = figure(2); clf;
% yyaxis left
% plot(t,Sq,'b--','linewidth',2);
% yyaxis right
% plot(t,IA+IS,'r-.','linewidth',2);
% TITLE = title('SQ (L axis) vs IA+IA (R axis)'); TITLE.Interpreter = 'latex';
% L = legend({'$Sq$','$IA+IS$'}); L.Interpreter = 'latex';
% 
% 
% f3 = figure(3); clf;
% yyaxis left
% plot(t,Sq,'b--','linewidth',2);
% yyaxis right
% plot(t,tbar,'g-.','linewidth',2);
% TITLE = title('Q vs. tbar'); TITLE.Interpreter = 'latex';
% L = legend({'$Sq$','$tbar$'}); L.Interpreter = 'latex';



% f4 = figure(3); clf;
% yyaxis left
% plot(t,tbar,'b--','linewidth',2); hold on;
% plot(t,mu,'g-.','linewidth',2);
% yyaxis right
% plot(t,IA+IS+IAq+ISq,'r-.','linewidth',2);
% TITLE = title('TsTr vs INfections'); TITLE.Interpreter = 'latex';
% L = legend({'$tbar(L)$','mu(L)','Total Inf (R)'}); L.Interpreter = 'latex';
% 
% 
% 
% 
% 
% 
% TOT=IAq+IA+ISq+IS;
% TOTAL=sum(TOT);
% Rec=RA+RS+RAq+RSq;
% Recov=Rec(end);
% Q=sum(Sq+IAq+ISq+Jq+RAq+RSq+Eq);
% LTsS=sum(LTs);
% TBAR=sum(tbar);
% IStot=sum(ISq+IS);
% 
% %plot(t,IA,'b-')
% %hold on
% %plot(t,Sq,'r*')
