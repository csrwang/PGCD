% =====================================================================
% Code for PGCD:
% =====================================================================
clear all;
clc;
warning off;

fprintf('run officehome \n');
%%   set parameters
global ANS; 
ANS = [];

options.Kfind = 5;           
options.T = 20;        % iterations
 
k_choose = 70;
lambda_choose = 0.01;
K_choose = 5;
fai_choose = 1;
fai2_choose = 1;
faim_choose = 1;


options.k = k_choose;
options.lambda = lambda_choose;
options.K = K_choose;
options.fai = fai_choose;
options.fai1 = fai_choose;
options.fai2 = fai2_choose;
options.faim = faim_choose;


%% datasets

 srcStr = {'Art_Art','Art_Art','Art_Art','Clipart_Clipart','Clipart_Clipart','Clipart_Clipart','Product_Product','Product_Product','Product_Product','RealWorld_RealWorld','RealWorld_RealWorld','RealWorld_RealWorld'};
 tgtStr = {'Art_Clipart','Art_Product','Art_RealWorld','Clipart_Art','Clipart_Product','Clipart_RealWorld','Product_Art','Product_Clipart','Product_RealWorld','RealWorld_Art','RealWorld_Clipart','RealWorld_Product'};

for iData = 1:12
    src = char(srcStr{iData});
    tgt = char(tgtStr{iData});
    options.data = strcat(src,'_vs_',tgt);
    options.data_num = iData;
    

    %% data processing
    [CXs,CXt,CYs,CYt] = prepare_home_zscore(src,tgt);


    %% 
    options.xt = CXt;
    options.yt = CYt;
    options.xs = CXs;
    options.ys = CYs;
    
    
    %% accuracy
    [iacc, ~]= calculation_acc(options);

end





