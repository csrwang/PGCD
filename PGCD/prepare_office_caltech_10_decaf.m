function [Xs,Xt,Ys,Yt] = prepare_office_caltech_10_decaf(src,tgt)    
% Preprocess data using Z-score
datapath = './dataset/office_caltech_10/decaf10';

    load(fullfile(datapath,[src,'.mat']));

    Xs = feas';
    Xs = Xs*diag(sparse(1./sqrt(sum(Xs.^2)))); 
    Xs = zscore(Xs',1);

    Xs = Xs';
    Ys = labels;
    
    
    
    load(fullfile(datapath,[tgt,'.mat'])); 

    Xt = feas';
    Xt = Xt*diag(sparse(1./sqrt(sum(Xt.^2)))); 
    Xt = zscore(Xt',1);

    Xt = Xt';
    Yt = labels;
    
end