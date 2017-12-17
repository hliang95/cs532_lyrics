A = load('newlyrics.mat');
A = A.M;

[m,n] = size(A);
% choose rank
r = 9;

% initialize W
W = abs(randn(m,r));

past_loss = 0;

% iterate
for i = 1:1000
    % first LS
    H = (W' * W) \ W' * A;

    H = H.* (H >= 0);
    
    % second LS
    W = ((H * H') \ H * A')';
    
    W = W .* (W >= 0);
    
    if abs((norm((A - W * H),'fro'))^2 - past_loss) < 0.00001
        break
    end
    past_loss = (norm((A - W * H),'fro'))^2;
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
    cluster = [cluster; cluster_num];
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