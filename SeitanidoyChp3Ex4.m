V=[41,46,47,47,48,50,50,50,50,50,50,50,...
    48,50,50,50,50,50,50,50,52,52,53,55,...
    50,50,50,50,52,52,53,53,53,53,53,57,...
    52,52,53,53,53,53,53,53,54,54,55,68];
s=var(V,0,2);
m=mean(V);
[~,~,ci,~]=vartest(V,s);
d=['The confidence interval for the varianve is: ',num2str(ci)];
disp(d),fprintf('\n')
h1=vartest(V,25);
if h1==0
    disp('5kV is the deviation of the sample.'),fprintf('\n')
else
    disp('5kV is not the deviation of the sample.'),fprintf('\n')
end
[~,~,cim,~]=ttest(V,m);
d=['The confidence interval for the mean is: ',num2str(cim)];
disp(d),fprintf('\n')
h2=ttest(V,52);
if h2==1
    disp('52kV is not a mean of the sample.'),fprintf('\n')
else
    disp('52kV is a mean of the sample.'),fprintf('\n')
end
[h3,p]=chi2gof(V);
if h3==0
    disp('The sample follows the normal distribution.'),fprintf('\n')
else
    disp('The sample does not follow the normal distribution'),fprintf('\n')
end
d=['The p-value of the goodness-of-fit test is: ',num2str(p)];
disp(d)