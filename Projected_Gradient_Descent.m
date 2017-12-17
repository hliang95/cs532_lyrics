A = load('newlyrics.mat');
A = A.M;

[m,n] = size(A);
r = 8;

% learning rate
alpha = 0.001;

W = abs(randn(m,r));
H = abs(randn(r,n));

past_loss = 0;
for k = 1:10000

    %Gradient h
    G_h = W' * (W * H - A);
    
    %Gradient w
    G_w = (W * H - A) * H'; 

    %calculate new_w
    H = H - alpha * G_h;
    
    %calculate new_h
    W = W - alpha * G_w;

    %project onto a nonnegative feasible region
    H = H.*(H>=0);
    W = W.*(W>=0);

    disp(past_loss)
    %Stopping Criteria
    if abs(0.5 * (norm((A - W * H),'fro'))^2 - past_loss) < 0.0001
        break
    end
    past_loss = 0.5 * (norm((A - W * H),'fro'))^2;
end

cluster = [];
for i = 1:m
    max_weight = 0;
    cluster_num = 0;
    weight_vector = W(i,:);
    for j = 1:r
        if weight_vector(:,j) >= max_weight
            max_weight = weight_vector(:,j);
            cluster_num = j;
        end
    end
    cluster = [cluster; [i cluster_num]];
end

disp('cluster')
disp(cluster)

top_words = [];
for i = 1:r
    word_row = H(i,:);
    [B,I] = sort(word_row, 'descend');
    top_words = [top_words; I(:,1:10)];
end

disp('top words for each cluster')
disp(top_words)