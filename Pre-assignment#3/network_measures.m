%In this pre-assignment the task is to test the Brain Connectivity Toolbox
%The macaque network from https://sites.google.com/site/bctnet/datasets was
clear;

%load the dataset
load('macaque71.mat');

%% Degree and Similarity

% Degree:
% degrees_und.m (BU, WU networks); degrees_dir.m (BD, WD networks).

% degrees = degrees_und(CIJ);
% figure(1);
% subplot(3,1,1)
% stem(degrees)
% subplot(3,1,2)
% %set(gca, 'xtick',1:71,'xticklabel',Names);
% histogram(degrees)
% subplot(3,1,3)
% boxplot(degrees)


[id,od,deg]=degrees_dir(CIJ);

plot_measure(id, 'in-degrees','in-degrees');
plot_measure(od, 'out-degrees','out-degrees');


% 
% Strength: 
% strengths_und.m (WU networks); strengths_dir.m (WD networks).
% strengths_und_sign.m (WU signed networks).

% Binary network is used here, so strengths are same as degrees
% 
% str=strengths_und(CIJ);  
% plot_measure(str, 'node strengths', 'node strengths');
% 
 [is,os,str] = strengths_dir(CIJ);
 plot_measure(is, 'node instrength', 'node instrength');
 plot_measure(os, 'node outstrength', 'node outstrength');


% Joint degree
% jdegree.m (BD, WD networks).

[J,J_od,J_id,J_bl] = jdegree(CIJ);
figure;
imagesc(J);
title('Joint degree');
c=colorbar('Ticks',[1,2,3]);
xlabel('Number of inward connections');
ylabel('Number of outward connections');
c.Label.String='Number of nodes';


% Topological overlap: 
% gtom.m (BU networks).

gt=gtom(CIJ,1);
figure;
imagesc(gt);
title('Generalized topological overlap measure')
xlabel('Node index');
ylabel('Node index');
c=colorbar;

% 
% Neighborhood overlap: 
% edge_nei_overlap_bu.m (BU networks); edge_nei_overlap_bd.m (BD networks).

[EC,ec,degij] = edge_nei_overlap_bd(CIJ);
figure;
imagesc(EC);
title('Overlap amongst neighbors of two adjacent nodes');
xlabel('Node index');
ylabel('Node index');
c=colorbar;

% Matching index: 
% matching_ind_und.m (BU networks); matching_ind.m (BD networks).

[Min,Mout,Mall] = matching_ind(CIJ);

figure;
imagesc(Min);
title('Matching index for incoming connections');
xlabel('Node index');
ylabel('Node index');
colorbar;

figure;
imagesc(Mout);
title('Matching index for outgoing connections');
xlabel('Node index');
ylabel('Node index');
colorbar;

figure;
imagesc(Mall);
title('Matching index for all connections');
xlabel('Node index');
ylabel('Node index');
colorbar;


%% Density and Rentian Scaling:

% density_und.m (BU, WU networks); density_dir.m (BD, WD networks).
% Contributor: OS.

[kden,N,K] = density_dir(CIJ);
density = ['Density = ',num2str(kden)];
disp(density);
vertices = ['Number of vertices = ',num2str(N)];
disp(vertices);
no_edges = ['Number of edges = ',num2str(K)];
disp(no_edges);


% Rentian scaling: 

% rentian_scaling_2d.m; rentian_scaling_3d.m (BU networks).
% Contributor: DB. 



%% Clustering and Community Structure

% clustering_coef_bu.m (BU networks); clustering_coef_bd.m (BD networks);
% clustering_coef_wu.m (WU networks); clustering_coef_wd.m (WD networks);
% clustering_coef_wu_sign.m (WU signed networks).

C = clustering_coef_bd(CIJ);
plot_measure(C,'clustering coefficent','clustering coefficent');


% Transitivity: 
% 
% transitivity_bu.m (BU networks); transitivity_bd.m (BD networks);
% transitivity_wu.m (WU networks); transitivity_wd.m (WD networks).
% Contributors: AG, MR.

T = transitivity_bd(CIJ);
transitiv = ['Transitivity scalar = ',num2str(T)];
disp(transitiv);


% Local efficiency: 
% 
% efficiency_bin.m (BU, BD networks); efficiency_wei.m (WU, WD networks).
% Contributor: MR.

Eglob=efficiency_bin(CIJ);
g_effi = ['global efficiency = ',num2str(Eglob)];
disp(g_effi);
Eloc=efficiency_bin(CIJ,1);
plot_measure(Eloc,'Local Efficiency','local efficiency');

%Connected components: 
% get_components.m (BU networks).


% Community structure and modularity: 
% community_louvain.m (BU, WU, BD, WD, signed networks)
% Louvain community detection algorithm with added finetuning.

M = community_louvain(CIJ);
figure();
subplot(3,1,1)
    stem(M)
    xlabel('node index')
    ylabel('Louvain community');
    title('Louvain communities');
subplot(3,1,2)
    histogram(M,4);
%    xticks([1,2,3,4]);
    xlabel('Louvain community')
    ylabel('amount of nodes');
subplot(3,1,3)
    boxplot(M)
    ylabel('Louvain community');
    
    
% modularity_und.m (BU, WU networks); modularity_dir.m (BD, WD networks)
% Newman's spectral community detection.

Ci = modularity_und(CIJ);
figure();
subplot(3,1,1)
    stem(Ci)
    xlabel('node index')
    ylabel({'Newman spectral','community'});
    title('Newman spectral community');
subplot(3,1,2)
    histogram(Ci,4);
%    xticks([1,2,3,4]);
    xlabel('Newman spectral community')
    ylabel('amount of nodes');
subplot(3,1,3)
    boxplot(Ci)
    ylabel({'Newman spectral','community'});
 
% link_communities.m (BU, WU, BD, WD networks)
% Link-based community-detection algorithm (detects overlapping communities).
%%
M2 = link_communities(CIJ);
figure
imagesc(M2);
c=colorbar('Ticks',[0,1]);
colormap(summer(2));
c.Label.String='Node i in community j (no/yes)';
title('Link communities');
xlabel('Node index');
ylabel('Community index');
%%
% clique_communities.m (BU networks)
% Clique-percolation community-detection algorithm (detects overlapping communities).


% Modularity degeneracy and consensus partitioning:
% agreement.m, agreement_weighted.m (BU, BD, WU, WD networks).
% consensus_und.m (BU, BD, WU, WD networks).
% Note: the inputs to these functions are not networks but some partitions of these networks (or derivatives of these partitions).


%% Assortativity and Core Structure:

% Assortativity: 
% assortativity_bin.m (BU, BD networks).

r = assortativity_bin(CIJ,1);
out_in=['out-degree/in-degree correlation = ', num2str(r)];
disp(out_in);
r = assortativity_bin(CIJ,2);
in_out = ['in-degree/out-degree correlation = ', num2str(r)];
disp(in_out);
r = assortativity_bin(CIJ,3);
out_out=['out-degree/out-degree correlation = ', num2str(r)];
disp(out_out);
r = assortativity_bin(CIJ,4);
in_in=['in-degree/in-degree correlation = ', num2str(r)];
disp(in_in);

% Rich club coefficient: 
% rich_club_bu.m (BU networks); rich_club_bd.m (BD networks).
% rich_club_wu.m (WU networks); rich_club_wd.m (WD networks).
R = rich_club_bd(CIJ);
figure();
subplot(3,1,1)
    stem(R)
    xlabel('degree of nodes');
    ylabel('rich club coeff');
    title('rich club coefficent');
subplot(3,1,2)
    histogram(R);
    xlabel('rich club coeff');
    ylabel('amount of nodes');
subplot(3,1,3)
    boxplot(R)
    ylabel('rich club coeff');

% Core/periphery structure: 
% core_periphery_dir.m (BU, BD, WU, WD networks).

C = core_periphery_dir(CIJ);
figure
subplot(2,1,1)
    stem(C);
    xlabel('node index')
    ylabel('0=periphery, 1=core');
%    yticks([0 1]);
    title('Core/periphery structure');
subplot(2,1,2)
    histogram(C);
    xlabel('0=periphery, 1=core');
%    xticks([0,1]);    
    ylabel('amount of nodes');


% K-core:
% kcore_bu.m (BU networks); kcore_bd.m (BD networks).
[CIJkcore,kn,peelorder,peellevel] = kcore_bd(CIJ,10);
figure
imagesc(CIJkcore);
colormap(summer(2));
c=colorbar('ticks',[0,1]);
title('K-core connection matrix for nodes with degree > 9');
xlabel('Node index');
ylabel('Node index');


%% Paths and Distances
%Paths and walks:
%set maximum path length for functions findpaths and cycprob
%(computationally intensive if high)
qmax = 5;
[Pq,tpath,plq,qstop,allpths,util] = findpaths(CIJ,1:71,qmax,0);
figure()

for i = 2:5
    subplot(2,2,i-1)
    imagesc(Pq(:,:,i));
    title(['Paths of length ', num2str(i)]);
    colorbar
    xlabel('node index');
    ylabel('node index');
end


[Wq,twalk,wlq] = findwalks(CIJ);
figure();
for i = 2:5
    subplot(2,2,i-1)
    imagesc(Wq(:,:,i));
    title(['Walks of length ', num2str(i)]);
    colorbar
    xlabel('node index');
    ylabel('node index');
end





%Distance and characteristic path length:

db = distance_bin(CIJ);
figure();
imagesc(db)
colorbar
title('lengths of shortest paths between nodes');
xlabel('node index');
ylabel('node index');
%Characteristic path length, global efficiency, eccentricity, radius, diameter:
[lambda,efficiency,ecc,radius, diameter] = charpath(db,0,0);
plot_measure(ecc,'nodal eccentricity','Nodal eccentricity');

%Cycle probability: 

[fcyc, pcyc] = cycprob(Pq);
for i = 1:numel(fcyc)
    disp(['fraction of all paths that are cycles for path length ', num2str(i),': ', num2str(fcyc(i))]);
end

for i = 1:numel(pcyc)
    disp(['probability that a non-cyclic path of length ', num2str(i-1),' can be extended to form a cycle of length ', num2str(i),': ',num2str(pcyc(i))]);
end
%% Efficiency and Diffusion
%Global and local efficiency:
Eglob = efficiency_bin(CIJ);
Eloc = efficiency_bin(CIJ,1);
disp(['Global efficiency: ', num2str(Eglob)]);
plot_measure(Eloc, 'local efficiency','Local efficiency');

%Mean first passage time: 

MFPT = mean_first_passage_time(CIJ);
figure();
imagesc(MFPT);
title('Mean first passage time');
xlabel('node index');
ylabel('node index');
c = colorbar;
c.Label.String = 'time';

%Diffusion efficiency: 
[GEdiff, Ediff] = diffusion_efficiency(CIJ);
figure
imagesc(Ediff);
title('Pair-wise diffusion efficiency');
xlabel('node index');
ylabel('node index');
colorbar

%Resource efficiency
lambda = 0.4;
[Eres, prob_SPL] = resource_efficiency_bin(CIJ,lambda);
%Eres has complex numbers. I don't know if this is intended. Using abs to
%get plots
figure();
imagesc(abs(Eres))
title('Resource efficiency');
xlabel('node index');
ylabel('node index');
colorbar

%Path transitivity: 
T = path_transitivity(CIJ);
figure();
imagesc(T)
title('Path transitivity');
xlabel('node index');
ylabel('node index');
c = colorbar;
c.Label.String = 'transitivity';
%Search information:

SI = search_information(CIJ);
figure
imagesc(SI)
title('Search information');
xlabel('node index');
ylabel('node index');
c = colorbar;
c.Label.String = 'bits';

%% Centrality

%Betweenness centrality:
bc =betweenness_bin(CIJ);
plot_measure(bc, 'betweenness centrality','Betweenness centrality');

%Edge betweenness centrality
ebc = edge_betweenness_bin(CIJ);
figure();
%create a heatmap where each point is a edge between two nodes
imagesc(ebc);
ylabel('node index');
xlabel('node index');
title('edge betweenness centrality');
colorbar

%M louvain communities
%Ci newman's spectral communities

%Within-module degree z-score:
%%
Z1 = module_degree_zscore(CIJ,M,0);
Z2 = module_degree_zscore(CIJ,Ci,0);
plot_measure(Z1,'z-score','Within-module degree z-score with Louvain communities ')
plot_measure(Z2,'z-score','Within-module degree z-score with Newmans spectral communities ')

%Participation and related coefficients:

P1 = participation_coef(CIJ,M,0);
P2 = participation_coef(CIJ,Ci,0);
plot_measure(P1, 'coefficient','Participation coefficient with Louvain communities');
plot_measure(P2, 'coefficient','Participation coefficient with Newmans spectral communities');

%Eigenvector centrality: 
ec = eigenvector_centrality_und(CIJ);
plot_measure(ec, 'eigenvector centrality', 'Eigenvector centrality');

%PageRank centrality:
prc = pagerank_centrality(CIJ,0.5);
plot_measure(prc, 'pagerank centrality', 'Pagerank centrality');


%Subgraph centrality: 
sc = subgraph_centrality(CIJ);
plot_measure(sc,'subgraph centrality','subgraph centrality');

%K-coreness centrality: 
kcc = kcoreness_centrality_bu(CIJ);
plot_measure(kcc, 'k-coreness centrality', 'K-coreness centrality');

%Flow coefficient:
fc = flow_coef_bd(CIJ);
plot_measure(fc, 'flow coefficient','Flow coefficient');


[Erange,eta,Eshort,fs] = erange(CIJ);
%   Outputs:    Erange,     range for each edge, i.e. the length of the
%                           shortest path from i to j for edge c(i,j) AFTER
%                           the edge has been removed from the graph.
figure()
imagesc(Erange)
title('Shortcuts');
xlabel('node index');
ylabel('node index');
colorbar
eta = ['average range for entire graph: ', num2str(eta)];
disp(eta);
fs = ['fraction of shortcuts in the graph: ', num2str(fs)];
disp(fs);
%% Motifs
%Structural motifs:
[f,F]= motif3struct_bin(CIJ);
figure();
imagesc(F);
xlabel('nodeindex');
ylabel('motif id');
c = colorbar;
c.Label.String = 'frequency';
title('Structural motifs');


%Functional motifs: 
[f,F]= motif3funct_bin(CIJ);
figure();
imagesc(F);
xlabel('nodeindex');
ylabel('motif id');
c = colorbar;
c.Label.String = 'frequency';
title('Functional motifs');