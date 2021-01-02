M=1000;
n=[5,100];
t=15; %1/t=0.066667
x=SeitanidoyChp3Ex2_expo(M,n(1),t);
[~,~,ci,~]=ttest(x,1/t);
ci1=fliplr(1./ci);
d=['The confidence interval of the mean lifetime for n=5 is: ',num2str(ci1)];
disp(d),fprintf('\n')

y=SeitanidoyChp3Ex2_expo(M,n(2),t);
[~,~,ci,~]=ttest(y,1/t);
ci2=fliplr(1./ci);
d=['The confidence interval of the mean lifetime for n=100 is: ',num2str(ci2)];
disp(d)

%λειπει το ποσοστο!!!!!!