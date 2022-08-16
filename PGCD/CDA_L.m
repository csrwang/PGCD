function [L,D,W] = CDA_L(X,Ys,Yt_new,C,options) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% local cross-domain alignment item
% pseudo labels
% k-nearest neighbor method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(Yt_new)
    

num = size(X,2); %% ns+nt
X = X';  
K = options.K;
Kfind = options.Kfind;

Wij = zeros(num,num);

ns = size(Ys,1);
nt = size(Yt_new,1);

Wij1 = zeros(ns,nt);

flag = 0;  

for c = 1:C
    
    X_Xs = X(1:ns,:);
    X_Xt = X(ns+1:end,:);
    
    %%% Find the index of the c-th class of the source domain
    Ys_matrix = zeros(ns,1);
    Ys_matrix(Ys==c) = 1;
    Ys_idx = Ys_matrix==1;
    
    %%% Extract source domain samples in class c
    X_Xs = X_Xs(Ys_idx,:);
    ns_c = size(X_Xs,1);
    
    %%% Find the index of the c-th class of the target domain
    Yt_matrix = zeros(nt,1);
    Yt_matrix(Yt_new==c) = 1; 
    Yt_idx = find(Yt_matrix==1);
                     
    
    X_Xt = X_Xt(Yt_idx,:);
    nt_c = size(X_Xt,1);

    IDX = knnsearch(X_Xt, X_Xs, 'K', Kfind, 'distance', 'cosine');   %%cosine   
     
%     IDX1 = knnsearch(X_Xt, X_Xs, 'K', Kfind, 'distance', 'euclidean');  %% other distances   
%     IDX2 = knnsearch(X_Xt, X_Xs, 'K', Kfind, 'distance', 'cityblock');  %% other distances
     
    
    for i = 1:ns_c
        Xs_c = X_Xs(i,:); 
        Xt_c = X_Xt(IDX(i,:),:); 
        
       %% heat kernel function
        X_d = Xt_c - Xs_c;
%       X_e = sum(X_d.^2,2); 
        X_e = exp(-0.5*sum(X_d.^2,2)); %%heat kernel function
        
 
        flag = flag + 1;
        Wij1(flag,Yt_idx(IDX(i,:))) = X_e;
        
        
    end
end


%%% bulid the adjacency matrix
Wij(1:ns,ns+1:end) = Wij1;
Wij(ns+1:end,1:ns) = Wij1';

W = Wij;
D = diag(sum(W,2));
L = D - W; 
 
else

    W = 0;
    D = 0;
    L = 0;

end

end

