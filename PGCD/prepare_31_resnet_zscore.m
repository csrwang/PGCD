function [Xs,Xt,Ys,Yt] = prepare_31_resnet_zscore(src,tgt)    
% Preprocess data using Z-score

    datapath = './dataset/office31/resnet50';


    load(fullfile(datapath,[src,'.mat']));
    fts = double(fea);
    Xs = zscore(fts,1);
    
    Xs = Xs';
    Ys = labels;
    
    
    load(fullfile(datapath,[tgt,'.mat'])); 
    fts = double(fea);
    Xt = zscore(fts,1);
    
    Xt = Xt';
    Yt = labels;
    
end