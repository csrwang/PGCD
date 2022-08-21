function [Xs,Xt,Ys,Yt] = prepare_31_decaf_zscore(src,tgt)    
% Preprocess data using Z-score

    datapath = './dataset/office31/decaf7';

    load(fullfile(datapath,[src,'.mat']));
    fts = double(fts);
    Xs = zscore(fts,1);
    Xs = Xs';
    Ys = labels;
    
    load(fullfile(datapath,[tgt,'.mat'])); 
    fts = double(fts);
    Xt = zscore(fts,1);
    Xt = Xt';
    Yt = labels;
    
end