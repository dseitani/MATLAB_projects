Data=importdata('eruption.dat');
s=var(Data); stest=[100,1,100];
m=mean(Data); mtest=[75,2.5,75];
civ=zeros(2,3);cim=zeros(2,3);
hv=zeros(1,3);hm=zeros(1,3);
h=zeros(1,3); p=zeros(1,3);
y=[1989,1989,2006]; txt=["the waiting time","the duration","the waiting time"];
for i=[1,2,3] %computes all the issues
[~,~,civ(:,i),~]=vartest(Data(:,i),s(i));
[~,~,cim(:,i),~]=ttest(Data(:,i),m(i));
hv(i)=vartest(Data(:,i),stest(i));
hm(i)=ttest(Data(:,i),mtest(i));
[h(i),p(i)]=chi2gof(Data(:,i));
end
fprintf('The 95%% confidence interval for the deviation of the waiting time in 1989 is: [%.4f %.4f] \n',sqrt(civ(:,1).'))
fprintf('The 95%% confidence interval for the deviation of the duration in 1989 is: [%.4f %.4f] \n',sqrt(civ(:,2).'))
fprintf('The 95%% confidence interval for the deviation of the waiting time in 2006 is: [%.4f %.4f] \n \n',sqrt(civ(:,3).'))
for i=[1,2,3]
    if hv(i)==1
        fprintf('%d min is not the deviation for %s in %d \n',sqrt(stest(i)),txt(i),y(i))
    else
        fprintf('%d min is the deviation for %s in %d \n',sqrt(stest(i)),txt(i),y(i))
    end
end
fprintf('\n')
fprintf('The 95%% confidence interval for the mean of the waiting time in 1989 is: [%.4f %.4f] \n',cim(:,1).')
fprintf('The 95%% confidence interval for the mean of the duration in 1989 is: [%.4f %.4f] \n',cim(:,2).')
fprintf('The 95%% confidence interval for the mean of the waiting time in 2006 is: [%.4f %.4f] \n \n',cim(:,3).')
for i=[1,2,3]
    if hm(i)==1
        fprintf('%.1f min is not the mean for %s in %d \n',mtest(i),txt(i),y(i))
    else
        fprintf('%.1f min is the mean for %s in %d \n',mtest(i),txt(i),y(i))
    end
end
fprintf('\n')
for i=[1,2,3]
    if h(i)==1
        fprintf('The sample does not follow the normal distribution for %s in %d \n',txt(i),y(i))
        fprintf('The p-value of the goodness-of-fit test is: %.4e \n \n',p(i))
    else
        fprintf('The sample follows the normal distribution for %s in %d \n',txt(i),y(i))
        fprintf('The p-value of the goodness-of-fit test is: %.4e \n \n',p(i))
    end   
end
%checking the claim from wikipedia
claim1="10' error,65' waiting,less than 2.5' duration";
claim2="10' error,91' waiting, more that 2.5' duration";
h1=vartest(Data(:,1),100); h2=ttest(Data(:,1),65);h3=ttest(Data(:,2),2.5);
if h1==0 && h2==0 && h3==0
    fprintf('The claim: %s is valid \n',claim1)
else
    fprintf('The claim: %s is not valid \n',claim1)
end
h1=vartest(Data(:,1),100); h2=ttest(Data(:,1),91);h3=ttest(Data(:,2),2.5);
if h1==0 && h2==0 && h3==0
    fprintf('The claim: %s is valid \n',claim2)
else
    fprintf('The claim: %s is not valid \n',claim2)
end