% =====================================================================
% Code for PGCD:
% =====================================================================
clear all;
clc;
warning off;

fprintf('run office31_resnet50 \n');
%%   set parameters


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

%% datasets

srcStr = {'A_A','A_A','D_D','D_D','W_W','W_W'};
tgtStr = {'A_D','A_W','D_A','D_W','W_A','W_D'};


for iData = 1:6
    
   
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



