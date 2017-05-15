function [distribution] = functionA(vector,no_permu)
% HBC course 2017
% assignment 4

distribution=zeros(1,no_permu);

for a=1:no_permu;
  
random_bin_seq=randi([0,1],1,length(vector));
random_bin_seq(random_bin_seq==0)=-1;
surrogate=random_bin_seq.*vector;
surr_mean=mean(surrogate);
distribution(a)=surr_mean;

end

figure
hist(distribution,10);
colormap('summer');
title('Distribution of surrogate vector means');
hold on
ylim=get(gca,'ylim');
line([mean(distribution) mean(distribution)],ylim,'color','r');

fraction_smaller=length(find(distribution<mean(vector)))/no_permu;
p_value=['p=',num2str(1-fraction_smaller)];
    disp(p_value);
    
end