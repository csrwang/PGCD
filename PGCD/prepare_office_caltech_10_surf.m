function [Xs,Xt,Ys,Yt] = prepare_office_caltech_10_surf(src,tgt)    
% Preprocess data using Z-score
datapath = './dataset/office_caltech_10/surf10';

    load(fullfile(datapath,[src,'.mat']));
    fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
    Xs = zscore(fts,1);
    Xs = Xs';
    Ys = labels;
    
    load(fullfile(datapath,[tgt,'.mat'])); 
	fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
    Xt = zscore(fts,1);
    Xt = Xt';
    Yt = labels;
    
end