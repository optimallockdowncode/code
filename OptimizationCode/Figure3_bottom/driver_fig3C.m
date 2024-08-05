clear; close all;

fprintf('Running SEIR simulation with Quarantine...\n');
addpath('../');
%% choose independent variables and values
INDEP_VARIABLE1 = "vsl";
INDEP_VARIABLE2 = "b1";
vals1 = 40:5:90;
vals2 = 0.01:0.01:0.09;

for count1 = 1:length(vals1)
    for count2 = 1:length(vals2)
    clearvars -except vals1 vals2 INDEP_VARIABLE1 INDEP_VARIABLE2 count1 count2 Y De totalQ N T eps
    fprintf('Running SEIR with Quarantine. Simulation %i / %i. %s = %.2f %s = %.2f \n',count2+length(vals2)*(count1-1),length(vals1)*length(vals2),INDEP_VARIABLE1,vals1(count1),INDEP_VARIABLE2,vals2(count2));
    %% ipopt settings
    ipopt = ...
        {'max_iter',10000
        'tol',1e-8
        };
    
    %% establish parameters and format for APM suite
    T = 365;
    dt = 1; % this is the finest resolution
            % for faster but rougher simulations, set dt = 2, 4 ,7, 14 (or
            %                                           whatever resolution
            %                                           you desire)
    t = 0:dt:T;
    
    
    %%%%
    N = 1;
    eps = 0.03;
    gamma = 0.15;
    m = 0.85; %Mask effectiveness
    
       
    %% set values of constants (name, value) 
   Constants = ...
        {'N', N;         %total population
        'eps', eps;      %initial infection size
        'beta', 0.24*m;   %bench = 0.24*  %transmission/contact rate %%% CORRECTED
        'sig',0.15;      %transfer from E to I
        'gamma',gamma;      %recovery rate
        'theta',0.25; %0.25     %mixing rate for quarantined population
        'tau',0.000;      %endemic (loss of immunity) rate
        'rho', 0.7; %0.7;       %work from home percentage
        'kappa',0.05*gamma; %excess deaths  was at 0.034
        'c1',1e-4;      
        'c2',1e-4;
        %'a',0.5; %weight on economic vs healthcare objective
       
        'b1', vals2(count2); %0.008; % bench = 0.01 
        'b2',13.5; %bench = 13.5
        'b3', 0.016; 
        'vsl',vals1(count1); %bench = 40
        };
    
    %% name control variables, give IC's and bounds
    Parameters = ...
        {'final','','';
        %'mu',0,'>= 0  <= 0.5';
        'tbar',0,'>=0 <= 1';
        'tsar',0,'>=0 <= 1';
        'p',0,'>= 0 <= 1';
        'pq',0,'>= 0 <= 1'
        };
    
    %% name state variables, give IC's and bounds (t is for time, Obj for objective)
    Variables = ...
        {'S',N*(1-eps),'>= 0 <= N';
        'Sq',0,'>= 0 <= N';
        'E',N*eps/2,'>= 0 <= N';
        'Eq',0,'>= 0 <= N';
        'IA',N*eps/2,'>= 0 <= N';
        'IAq',0,'>= 0 <= N';
        'IS',0,'>= 0 <= N';
        'ISq',0,'>= 0 <= N';
        'J',0,'>= 0 <= N';
        'Jq',0,'>= 0 <= N';
        'D',0,'>= 0 <= N';
        'RA',0,'>= 0 <= N';
        'RAq',0,'>= 0 <= N';
        'RS',0,'>= 0 <= N';
        'RSq',0,'>= 0 <= N';
        't',0,'';
        'Production',0,'';
        };
    
    %% some intermediate calculations
    Intermediates = ...
        {'lam = beta * (E + IA + theta * (Eq + IAq))/(S + E + IA + RA + RS + theta * (Sq + Eq + IAq + RAq + RSq))';
        
        'Ts1 = (S+E+IA+RA)*tbar';
        'Ts2 = (Sq+Eq+IAq+RAq)*tsar';
        'Ts = Ts1+Ts2';
        'LTs= (Ts)*15/200'; %CHANGE TO 10
       
        'N1 = S + E + IA + IS + J + RA + RS';
        'Nq = Sq + Eq + IAq + ISq + Jq + RAq + RSq';
        'Wf = N1-(1-rho)*J-IS+rho*(Nq - ISq) - LTs'; %% Took out Ltr from here
        %'Ts = tbar*(S+Sq+E+Eq+IA+IAq+RA+RAq)';
        'drate = 0.01*gamma + kappa*(IS+ISq)';  %new from Alvarez
        };
    
    %% equations we are solving (first objective of code, then diff eqs)
    Equations = ...
        {'maximize (final * Production)';
        '$t = 1';
        '$S  = -lam * S + tau * (RA + RS) - p * S + pq * Sq';
        '$Sq = -theta * lam * Sq + tau * (RAq + RSq) + p * S - pq * Sq';
        '$E  = lam * S - (sig + tbar*0.5) * E - p * E + pq * Eq';
        '$Eq = theta * lam * Sq - (sig + tsar*0.5 ) * Eq + p * E - pq * Eq';
        '$IA = 0.5 * sig * E  - (gamma + tbar*0.5 ) * IA  - p * IA + pq * IAq';
        '$IAq= 0.5 * sig * Eq - (gamma + tsar*0.5 ) * IAq + p * IA - pq * IAq';
        '$IS = 0.5 * sig * E - (gamma + drate) * IS - p * IS + pq * ISq';
        '$ISq= 0.5 * sig * Eq - (gamma + drate) * ISq + p * IS - pq * ISq';
        '$J  = tbar* 0.5 * (IA + E) - gamma * J - p * J + pq * Jq';
        '$Jq = tsar*0.5*(IAq + Eq) - gamma * Jq + p * J - pq * Jq';
        '$D = drate*(IS + ISq)';
        '$RA = gamma * IA - tau * RA - p * RA + pq * RAq';
        '$RAq = gamma * IAq - tau * RAq + p * RA - pq * RAq';
        '$RS  = gamma * (IS + J) - tau * RS - p * RS + pq * RSq';
        '$RSq = gamma * (ISq + Jq) - tau * RSq + p * RS - pq * RSq';
        % 	 '$Production  = (S + E + R + rho * (Sq + Eq + Rq))/N - c1 * u^2 / 2 - c2 * p^2 / 2 - c3 * pq^2 / 2'
        '$Production  = Wf/(365*N) - drate*(IS + ISq)*vsl/N - c1*(p^2+pq^2)-c2*((tbar+tsar)^2)';
        'Nq <= 0.7*N';
        %'Ts >=0';
        'Ts <=b1/(1+b2*exp(-b3*t))';  % BENCHMARK 0.008/(1+13.5*exp(-(0.016)*t))
        %'mu <=1';
      
        % UK smulation 0.017	200.616	0.018
        % US smulation 0.005	19.056	0.025
        
        %'LTr <= N / 500'; 
         %'LTr<= 0.001*N';
        };
    
    %write the csv and APM file for the APM optimization suite
    WriteAPMFile;
    WriteCsvFile;
    
    %% create APM optimization instance and solve problem
    s = 'http://byu.apmonitor.com';
    a = 'OptProb_SEIRwithQ';
    
    % add path to APM 
    addpath('../apm_matlab_v0.7.2/apm');
    
    apm(s,a,'clear all');
    apm_load(s,a,filenameAPM);
    csv_load(s,a,filenameCSV); %use filename from WriteCsvFile script
    
    %see apm documentation for explanation of these
    apm_option(s,a,'nlc.nodes',4); % collocation nodes (?)
    apm_option(s,a,'nlc.solver',3); % 3 == IPOPT
    apm_option(s,a,'nlc.imode',6);  % type of problem (?)
    apm_option(s,a,'nlc.mv_type',1); % linear interpolation
    
    apm_info(s,a,'MV','p'); % declare that p is a 'manipulated variable' (ie control)
    apm_option(s,a,'p.status',1); % turn this variable 'on'
    apm_option(s,a,'p.dcost',0); % no cost associated with changing p (add cost to smooth control map)
    
    apm_info(s,a,'MV','pq'); % declare that pq is a 'manipulated variable' (ie control)
    apm_option(s,a,'pq.status',1); % turn this variable 'on'
    apm_option(s,a,'pq.dcost',0); % no cost associated with changing pq (add cost to smooth)
    
    apm_info(s,a,'MV','tbar'); % declare that u is a 'manipulated variable' (ie control)
    apm_option(s,a,'tbar.status',1); % turn this variable 'on'
    apm_option(s,a,'tbar.dcost',0); % no cost associated with changing u (add cost to smooth control map)
    
    apm_info(s,a,'MV','tsar'); % declare that u is a 'manipulated variable' (ie control)
    apm_option(s,a,'tsar.status',1); % turn this variable 'on'
    apm_option(s,a,'tsar.dcost',0); % no cost associated with changing u (add cost to smooth control map)
    
    
    
    output = apm(s,a,'solve'); % solve problem
    disp(output);
    y = apm_sol(s,a); z = y.x; % load solution into z
    
    %% record certain quantities
    d = 2:(length(z.sq));
    % total person-days of quarantine
    totalQ(count1,count2) = dt*sum(z.sq(d) + z.eq(d) + z.iaq(d) + z.isq(d) + z.jq(d) + z.raq(d) + z.rsq(d));
    % total economic production
    %    Y(count) = dt*sum(z.n1(d)-(1-z.rho(d)).*z.j(d) - z.is(d) + z.rho(d).*(z.nq(d) - z.isq(d))-z.ltr(d)-z.lts(d));
    Y(count1,count2) = dt*sum(z.wf(d)); %using the "workforce" parameter established on line 96
    Tested(count1,count2)=dt*sum(z.ts(d));
    %%%% IS is missing in the formula
    % total death count
    De(count1,count2) = z.d(end);
    
    %% save current run
    %   This will create a MATLAB data file with the dynamics for each
    %   different alpha value.
    %   It may clutter your folders a bit; comment this out if you don't
    %   want that. It is here in case you want to plot the dynamics
    %   for a given value. To do so, load the appropriate file and run
    %   the "drawDynamics" script.
    %   NOTE: you do not need these files to run "drawTradeoff", which
    %   gives the Acemoglu type plots
    %     savestr = sprintf('results_alpha_%i.mat',round(100*alpha_vals(count)));
    %     alpha = alpha_vals(count);
    %     save(savestr,'alpha','N','T','eps','z');
    save('current_indiv_run.mat','vals1','vals2','N','T','eps','z','INDEP_VARIABLE1','INDEP_VARIABLE2');
    end
end

%% save full results for Acemoglu type plots in a data file called 'current.mat'
save current.mat vals1 vals2 Y De totalQ N T eps INDEP_VARIABLE1 INDEP_VARIABLE2
plotFigure3C;