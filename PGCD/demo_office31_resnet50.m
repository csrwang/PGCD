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
options.T = 25;        % iterations
 
k_choose = 30;
lambda_choose = 0.1;
K_choose = 5;
fai_choose = 0.1;
fai2_choose = 1;
faim_choose = 5;


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

srcStr = {'A_A','A_A','D_D','D_D','W_W','W_W'};
tgtStr = {'A_D','A_W','D_A','D_W','W_A','W_D'};


for iData = 6
    
   
    src = char(srcStr{iData});
    tgt = char(tgtStr{iData});
    options.data = strcat(src,'_vs_',tgt);
    options.data_num = iData;
           
 
    %% data processing
     [CXs,CXt,CYs,CYt] = prepare_31_resnet_zscore(src,tgt);

 
    
    %%
    options.xt = CXt;
    options.yt = CYt;
    options.xs = CXs;
    options.ys = CYs;
    

    %%  accuracy
    [iacc, ~]= calculation_acc(options);
 
                   
end


ANS_31_resnet50 = ANS;
save ANS_31_resnet50;
