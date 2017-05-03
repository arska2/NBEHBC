
%In this pre-assignment the task is to test the Brain Connectivity Toolbox
%network visualization.
%The macaque network from https://sites.google.com/site/bctnet/datasets was
%used
clear;

%load the dataset
load('macaque71.mat');


%% Visualization of networks in MATLAB
% adjacency_plot_und.m (BU network).
[x,y]=adjacency_plot_und(CIJ);
figure
plot(x,y,'g.-')
title('Adjacency plot');
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
set(gca,'color',[0.5,0.5,0.5]);



%% Visualization of matrices in MATLAB


% Grid communities: 
% grid_communities.m (BU, WU, BD, WD networks).
M = community_louvain(CIJ);
[X Y INDSORT] = grid_communities(M);
figure
imagesc(CIJ(INDSORT,INDSORT));         
hold on;                              
plot(X,Y,'r','linewidth',2);     
title('Louvain community structure');
xlabel('Reordered new node index');
ylabel('Reordered new node index');
colormap(summer(2));



% Network backbone: 
% backbone_wu.m (BU, WU networks).


%%
[CIJtree,CIJclus] = backbone_wu(CIJ,5);

tmp = CIJ;
tmp(find(CIJtree)) = 2;
figure();
imagesc(tmp);
colorbar('Ticks', [0,1,2],'TickLabels',{'No edge','Edge','edge in MST'});
title('Network backbone (Minimum Spanning Tree)');
xlabel('node index');
ylabel('node index');
%%

% Matrix alignment with simulated annealing: 
% align_matrices.m (BU, BD, WU, WD networks).

% No second network, so skipping


% Node reordering with simulated annealing:
% reorder_matrix.m (BU, BD, WU, WD networks).
[Mreordered,Mindices,cost] = reorder_matrix(CIJ,'line',1);
figure
imagesc(Mreordered);
colormap(summer(2));
title('Reordered connectivity matrix');
xlabel('New node index');
ylabel('New node index');
figure
imagesc(CIJ);
colormap(summer(2));
title('Original connectivity matrix');
xlabel('Node index');
ylabel('Node index');


% Node reordering by modular structure:
% reorder_mod.m (BU, BD, WU, WD networks).
[On,Wr] = reorder_mod(CIJ,M);
figure
imagesc(Wr);
title({'Connectivity matrix reordered','by modular structure'});
xlabel('New node index');
ylabel('New node index');
colormap(summer(2));
figure
imagesc(CIJ);
title('Original connectivity matrix');
xlabel('Node index');
ylabel('Node index');
colormap(summer(2));

M2 = community_louvain(Wr);
[X Y INDSORT] = grid_communities(M2);
figure
imagesc(Wr(INDSORT,INDSORT));         
hold on;                              
plot(X,Y,'r','linewidth',2);     
title({'Louvain community structure', 'in reordered matrix'});
xlabel('New node index');
ylabel('New node index');
colormap(summer(2));

% Node reordering:

[MATreordered,MATindices,MATcost] = reorderMAT(CIJ,50,'line');
figure
imagesc(CIJ);
colormap(summer(2));
title('Original connectivity matrix');
xlabel('Node index');
ylabel('Node index');
colorbar('Ticks', [0,1],'TickLabels',{'No edge','Edge'});

figure();
imagesc(MATreordered);
title({'Connectivity matrix reordered','to maximize number of edges close to the main diagonal'});
xlabel('New node index');
ylabel('New node index');
colormap(summer(2));
colorbar('Ticks', [0,1],'TickLabels',{'No edge','Edge'});