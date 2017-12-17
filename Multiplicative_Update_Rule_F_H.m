A = load('newlyrics.mat');
A = A.M;
% 102 songs; 1201 words

[m,n] = size(A);
% choose rank
r = 10;

W = abs(randn(m,r));
H = abs(randn(r,n));

for k = 1:10000

    H = H .* (W'* A) ./ (W' * W * H + 10^-9);
    W = W .* (A * H') ./ (W * H * H' + 10^-9);
    if (norm((A - W * H),'fro'))^2 < 1
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