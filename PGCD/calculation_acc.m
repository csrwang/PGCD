function [acc,A] = calculation_acc(options) 

    k = options.k;
    lambda = options.lambda;  
    Kfind = options.Kfind;
    K = options.K;
    data = options.data;



%% load data
    Xs = options.xs;
    Ys = options.ys;
    
    Xt = options.xt;
    Yt = options.yt;
    
    C = max(Ys);
    
    m = size(Xt,1);
    
    Cls = [];

    Xt0 = Xt;
        
    Xs = Xs*diag(sparse(1./sqrt(sum(Xs.^2))));  
    Xt = Xt*diag(sparse(1./sqrt(sum(Xt.^2))));
    
    %%%% pseudo labels
    Yt_new = [];

   
    accf = 0;

    for t = 1:options.T        

        fprintf('*');        
        [~, A] = PGCD(Xs,Xt0,Ys,Cls,Yt_new,options);
        
  
        old_Cls = Cls;

        Zs = real(A'*Xs);
        Zt = real(A'*Xt);
       
        
        model = fitcknn(Zs', Ys, 'NumNeighbors', 1, 'Distance', 'cosine');
        
        Cls = predict(model, Zt');
       
        %%%% pseudo labels
        Yt_new = Cls;
        
        
        acc = length(find(Cls==Yt))/length(Yt);

        
        if acc >= accf
            accf = acc;
        end

        
       %%  pseudo labels by KNN
        K = options.K;

        IDX = knnsearch(Zs', Zt', 'K', K, 'distance', 'cosine');
        
        Cls = zeros(size(IDX,1),length(unique(Ys)));
        for i = 1:size(Cls,2)
            Cls(:,i) = sum(Ys(IDX) == i,2);  %%%Count the number, the number of neighbors belonging to each class
        end
        Cls_c = Cls./K; 
        Cls = Cls_c;      %%%The probability that each sample belongs to each class

        
        %%  Exit mechanism in iteration
      
        if ( size(old_Cls,1) == size(Cls,1) && sum(sum(abs(old_Cls-Cls))) == 0 ) || t == options.T
            fprintf('\nPGCD:  data=%s  \n',data);
            fprintf('1NN Acc = %0.3f\n',accf);
            break;
        end
        
    end
       
end