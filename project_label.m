
%% SVD and PCA to see the visualize the clustering
clear all;
load('newlyrics.mat')
[U,S,V] = svd(M','econ');
indexm = S*V';
index3d = indexm(1:3,:);
figure(3);
clf;
scatter3(index3d(1,:),index3d(2,:),index3d(3,:),10,y,'filled');
colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('u1');ylabel('u2');
zlabel('u3')
title(['projection of songs'])

%% SVD visualize in 2d
index2d = indexm(1:2,:);
figure(2);
clf; 
scatter(index2d(1,:),index2d(2,:),10,y,'filled');
colormap jet;colorbar
set(gca,'fontsize',20);
xlabel('u1');ylabel('u2');
title(['projection of songs onto 2 D'])

%% SVD visualize the row projection
[Ur,Sr,Vr] = svd(M,'econ');
indexr = Sr*Vr';
indexr3d = indexr(1:3,:);
figure(4);
clf;
scatter3(indexr3d(1,:),indexr3d(2,:),indexr3d(3,:),10,'filled');
colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('u1');ylabel('u2');
zlabel('u3')
title(['projection of words'])

 