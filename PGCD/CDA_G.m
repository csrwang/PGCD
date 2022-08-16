function [L,D,W] = CDA_G(X,Ys,Yt_new,tp,C,options) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global cross-domain alignment item
% soft pseudo labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(Yt_new)
num = size(X,2);    %% ns+nt    
ns = size(Ys,1);
nt = size(Yt_new,1);

Wij1 = zeros(ns,nt); 
Wij = zeros(num,num);

tp = tp';       

for c = 1:C
    
    %%%Find the index of the c-th class of the source domain
    Ys_matrix = zeros(ns,1);
    Ys_matrix(Ys==c) = 1;
    Ys_idx = find(Ys_matrix==1);
    num_Ys_idx = size(Ys_idx,1);
    
    Wij1(Ys_idx ,:) = repmat( tp(c ,:), [ num_Ys_idx, 1 ] ); 
    %%B = repmat(A, m, n) % 
   
    
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


