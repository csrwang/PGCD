function [acc,A] = calculation_acc(options) 

global ANS; 

    k = options.k;
    lambda = options.lambda;
    
    Kfind = options.Kfind;
    K = options.K;
    data_num = options.data_num;
    fai2 = options.fai2;
    fai1 = options.fai1;
    fai = options.fai;
    faim = options.faim;



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

       
    %%%% save results
    ANS_temp = zeros(1,50);
    save_flag = 8;
    
    
    for t = 1:options.T        
       %%% save results
        ANS_temp(1) = data_num;
        ANS_temp(2) = k;
        ANS_temp(3) = lambda;
        ANS_temp(4) = faim;
        ANS_temp(5) = fai;
        ANS_temp(6) = fai1; 
        ANS_temp(7) = fai2;  
        
        fprintf('==============================Iteration [%d]==============================\n',t);
        
        [~, A] = PGCD(Xs,Xt0,Ys,Cls,Yt_new,options);
        
  
        old_Cls = Cls;

        Zs = real(A'*Xs);
        Zt = real(A'*Xt);
       
        
        model = fitcknn(Zs', Ys, 'NumNeighbors', 1, 'Distance', 'cosine');
        
        Cls = predict(model, Zt');
       
        %%%% pseudo labels
        Yt_new = Cls;
        
        
        acc = length(find(Cls==Yt))/length(Yt);
        
       %%%% save results
        ANS_temp(save_flag) = acc;
        save_flag = save_flag+1;
        
        fprintf('1NN Acc = %0.4f\n',acc);

        
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
      
        if size(old_Cls,1) == size(Cls,1) && sum(sum(abs(old_Cls-Cls))) == 0
            break;
        end
    end
    
    %%%% save results
    fprintf('*****')
    ANS = cat(1,ANS,ANS_temp);

    fprintf('**************************\n***************************')
    fprintf('\n\n\n');
       
end