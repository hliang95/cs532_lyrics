A = load('newlyrics.mat');
A = A.M;

[m,n] = size(A);
r = 10;

W = abs(randn(m,r));
H = abs(randn(r,n));

for k = 1:10000
    % update H
    H = H .* (W' * (A ./ (W * H + 10^-9)))./ (W' * ones(m,1) * ones(1,n));
    % update W
    W = W .* ((A./ (W * H + 10^-9)) * H') ./ (ones(m,1) * ones(1,n) * H');
    
    new_A = W * H;
    loss_f = 0;
    for i = 1:m
        for j = 1:n
            loss_f = loss_f + A(i,j) * log(A(i,j)/new_A(i,j)) - A(i,j) + new_A(i,j);
        end
    end
    if  loss_f < 1
        break
    end
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