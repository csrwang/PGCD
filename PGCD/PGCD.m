function [Z,A] = PGCD(Xs,Xt,Ys,Yt0,Yt_new,options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options.K is the soft label nearest neighbors $p$ in paper
% options.Kfind is the the cross-domain nearest neighbors $h$ in paper
% options.k is the projection space dimension $z$ in paper

% options.fai is the trade-off parameters $\alpha$ in paper
% options.fai1 is the trade-off parameters $\alpha$ in paper
% options.fai = options.fai1

% options.fai2 is the trade-off parameters $\beta$ in paper
% options.faim is the trade-off parameters $\gamma$ in paper
%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 5
    error('Algorithm parameters should be set!');
end

k = options.k;
lambda = options.lambda;
data = options.data;
Kfind = options.Kfind;
Xs = options.xs;
fai2 = options.fai2;
fai1 = options.fai1;
fai = options.fai;
faim = options.faim;



X = [Xs, Xt];
X = X*diag(sparse(1./sqrt(sum(X.^2)))); 
[m,n] = size(X);
ns = size(Xs,2);
nt = size(Xt,2);
C = max(Ys);

L = zeros(ns+nt);


%% build source class discriminative item
tp = full(sparse(1:ns,Ys,1));
tp2 = tp*diag(1./(eps+sum(tp)));
tp3 = tp2*tp';

%%% graph structure
W11 = tp3;
D11 = diag(sum(W11,2));
L11 = D11 - W11; 

L(1:ns,1:ns) = L11 ;




%% build MMD matrix
e = [1/ns*ones(ns,1);-1/nt*ones(nt,1)];
M = e*e'*C;   

tp0001 = 0;


if ~isempty(Yt0) && size(Yt0,1)==nt
      
    we = ones(max(Ys),1);
    for c = 1:C
        e = zeros(n,1);
        e(Ys==c) = 1/(eps+length(find(Ys==c)));
        
        %%%%% M with p
        e(ns+1:end) = -Yt0(:,c)/(eps+sum(Yt0(:,c)));
    
        e(isinf(e)) = 0;e(isnan(e)) = 0;    
     
        M = M + we(c)*e*e';
    end
    
 
    
    %% build target class discriminative item
    tp001 = Yt0;
   
    %%%    L_with_p
    tp0001 = tp001*diag(1./sum(tp001));
    tp0001(isnan(tp0001)) = 0;
    tp0002 = tp0001*tp001';
    W111 = tp0002;
    D111 = diag(sum(W111,2));
    L111 = D111 - W111; 
    
    L(ns+1:end,ns+1:end) = L111*L111';


end

M = M/norm(M,'fro');
L = L/(eps + norm(L,'fro'));  %%% data processing


%% build centering matrix
H = eye(n)-1/(n)*ones(n,n);


%% build cross-domain alignment item
%%% build local cross-domain alignment item  CDA_L
[ LL,DD,WW ] = CDA_L(X,Ys,Yt_new,C,options);  %%%knn find neighbors

%%% build global cross-domain alignment item  CDA_G
[LL01,DD01,WW01] = CDA_G(X,Ys,Yt_new,tp0001,C,options) ;
LL01 = LL01*LL01';


LL = LL/norm(LL,'fro');
LL01 = LL01/norm(LL01,'fro');

LL(isnan(LL)) = 0;
LL01(isnan(LL01)) = 0;
 

%% calculate the projection matrix A

    T = X*H*X';    

	[A,~] = eigs(lambda*speye(m)+X*(faim*M+fai*LL+fai1*LL01+fai2*L)*X', T, k,'sm'); 
          
    Z = real(A(:,1:end)'*X);
    
end