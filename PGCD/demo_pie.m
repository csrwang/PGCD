% =====================================================================
% Code for PGCD:
% =====================================================================
clear all;
clc;
warning off;

fprintf('run pie \n');
%%   set parameters

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

%% datasets

srcStr = {'PIE05','PIE05','PIE05','PIE05','PIE07','PIE07','PIE07','PIE07','PIE09','PIE09','PIE09','PIE09','PIE27','PIE27','PIE27','PIE27','PIE29','PIE29','PIE29','PIE29'};
tgtStr = {'PIE07','PIE09','PIE27','PIE29','PIE05','PIE09','PIE27','PIE29','PIE05','PIE07','PIE27','PIE29','PIE05','PIE07','PIE09','PIE29','PIE05','PIE07','PIE09','PIE27'};

for iData = 1:20
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



