function [Xs,Xt,Ys,Yt] = prepare_home_zscore(src,tgt)    
% Preprocess data using Z-score

    datapath = './dataset/officehome';

    load(fullfile(datapath,[src,'.mat']));
    fts = double(fea);
    Xs = zscore(fts,1);
    Xs = Xs';
    Ys = gnd;
    
    load(fullfile(datapath,[tgt,'.mat'])); 
    fts = double(fea);
    Xt = zscore(fts,1);
    Xt = Xt';
    Yt = gnd;
    
end