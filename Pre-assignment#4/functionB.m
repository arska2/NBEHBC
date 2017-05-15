function [distribution] = functionB(vec1,vec2, no_permu)
% HBC course 2017
% assignment 4
%  this function receives as input two vectors and a value
%  corresponding to the number of permutations. 
%  The function should then, at each permutation, 
%  swap a subset of values between the two vectors 
%  and compute the mean difference.
%  The function should return the list of surrogate values

%Assume that the vectors have the same length
if length(vec1) ~= length(vec2)
   disp('Error: vectors are not the same length');
   return
end

distribution=zeros(1,no_permu);
veclen = length(vec1);
real_mean = mean(vec1-vec2);


for a=1:no_permu;
%define how many values are swapped in range 1:veclen-1
%(veclen would just swap the whole vectors)
swap = randi(veclen-1);

%create tmp vectors to permute
tmp1 = vec1;
tmp2 = vec2;

%pick random subsets from vec1 and vec2
[sub1 ,idx] = datasample(vec1, swap,'Replace', false);
sub2 = vec2(idx);

%change subsets:
tmp1(idx) = sub2;
tmp2(idx) = sub1;

%calculate mean difference:
distribution(a) = mean(tmp1-tmp2);

end

figure
hist(distribution,10);
colormap('summer');
title('Distribution of mean differences');
hold on
ylim=get(gca,'ylim');

line([real_mean real_mean],ylim,'color','r');
fraction_smaller=length(find(distribution<mean(vec1)))/no_permu;
p_value=['p=',num2str(1-fraction_smaller)];
disp(p_value);
    
end