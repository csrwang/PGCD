% =====================================================================
% Code for PGCD:
% =====================================================================
clear all;
clc;
warning off;

fprintf('run office_caltech_10_surf \n');
%%   set parameters

options.Kfind = 5;           
options.T = 20;        % iterations
 
k_choose = 15;
lambda_choose = 0.1;
K_choose = 5;
faim_choose = 1;
fai_choose = 1;
fai2_choose = 1;


options.k = k_choose;
options.lambda = lambda_choose;
options.K = K_choose;
options.fai = fai_choose;
options.fai1 = fai_choose;
options.fai2 = fai2_choose;
options.faim = faim_choose;


%% datasets

srcStr = {'Caltech10_SURF_L10','Caltech10_SURF_L10','Caltech10_SURF_L10','amazon_SURF_L10','amazon_SURF_L10','amazon_SURF_L10','webcam_SURF_L10','webcam_SURF_L10','webcam_SURF_L10','dslr_SURF_L10','dslr_SURF_L10','dslr_SURF_L10'};
tgtStr = {'amazon_SURF_L10','webcam_SURF_L10','dslr_SURF_L10','Caltech10_SURF_L10','webcam_SURF_L10','dslr_SURF_L10','Caltech10_SURF_L10','amazon_SURF_L10','dslr_SURF_L10','Caltech10_SURF_L10','amazon_SURF_L10','webcam_SURF_L10'};


for iData = 1:12
    src = char(srcStr{iData});
    tgt = char(tgtStr{iData});
    options.data = strcat(src,'_vs_',tgt);
    options.data_num = iData;    
    

    %% data processing

    [CXs,CXt,CYs,CYt] = prepare_office_caltech_10_surf(src,tgt);
    
       
    %%
    options.xt = CXt;
    options.yt = CYt;
    options.xs = CXs;
    options.ys = CYs;
    
   
    %%  accuracy
    [iacc, ~]= calculation_acc(options);
 
    
end    


