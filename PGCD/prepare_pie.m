function [Xs,Xt,Ys,Yt] = prepare_pie(src,tgt)    
% Preprocess data 
    datapath = './dataset/pie';

    load(fullfile(datapath,[src,'.mat']));
    Xs = double(fea');
    Xs = Xs*diag(sparse(1./sqrt(sum(Xs.^2))));
    Ys = gnd;
    
    
    load(fullfile(datapath,[tgt,'.mat']));  
	Xt = double(fea');
    Xt = Xt*diag(sparse(1./sqrt(sum(Xt.^2))));
    Yt = gnd;
end