% =====================================================================
% Code for PGCD:
% =====================================================================
clear all;
clc;
warning off;

%%   set parameters
global ANS; 
ANS = [];


options.Kfind = 5;           
options.T = 20;        % iterations
 
k_choose = 100;
lambda_choose = 0.01;
K_choose = 5;
faim_choose = 1;
fai_choose = 5;
fai2_choose = 0.01;


options.k = k_choose;
options.lambda = lambda_choose;
options.K = K_choose;
options.fai = fai_choose;
options.fai1 = fai_choose;
options.fai2 = fai2_choose;
options.faim = faim_choose;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options.K is the soft label nearest neighbors $p$ in paper
% options.Kfind is the the cross-domain nearest neighbors $h$ in paper
% options.k is the projection space dimension $z$ in paper

% options.fai is the trade-off parameters $\alpha$ in paper
% options.fai1 is the trade-off parameters $\alpha$ in paper
% options.fai = options.fai1

% options.fai2 is the trade-off parameters $\beta$ in paper
% options.faim is the trade-off parameters $\gamma$ in paper
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% datasets

srcStr = {'PIE05','PIE05','PIE05','PIE05','PIE07','PIE07','PIE07','PIE07','PIE09','PIE09','PIE09','PIE09','PIE27','PIE27','PIE27','PIE27','PIE29','PIE29','PIE29','PIE29'};
tgtStr = {'PIE07','PIE09','PIE27','PIE29','PIE05','PIE09','PIE27','PIE29','PIE05','PIE07','PIE27','PIE29','PIE05','PIE07','PIE09','PIE29','PIE05','PIE07','PIE09','PIE27'};

for iData = 12
    src = char(srcStr{iData});
    tgt = char(tgtStr{iData});
    options.data = strcat(src,'_vs_',tgt);
    options.data_num = iData;
    

    %% data processing
    [CXs,CXt,CYs,CYt] = prepare_pie(src,tgt);
    
    

    %% 
    options.xt = CXt;
    options.yt = CYt;
    options.xs = CXs;
    options.ys = CYs;
    

    
    %%  accuracy
    [iacc, ~]= calculation_acc(options);


end
        
ANS_pie = ANS;
save ANS_pie;




