M=1000;
n=20; %for question c change to 200
X1=zeros(n,M); X2=zeros(n,M);
Y1=zeros(n,M); Y2=zeros(n,M);
mu=[0; 0];
sigma1=[1 1];
sigma2=[1 0.5; 0.5 1];
for i=1:M
    xy1=mvnrnd(mu,sigma1,n);
    xy2=mvnrnd(mu,sigma2,n);
    X1(:,i)=(xy1(:,1));%.^2; %change to .^2 for question d
    Y1(:,i)=(xy1(:,2));%.^2;
    X2(:,i)=(xy2(:,1));%.^2;
    Y2(:,i)=(xy2(:,2));%.^2;
end
%question a
X1m=mean(X1); Y1m=mean(Y1);
X2m=mean(X2); Y2m=mean(Y2);
SX1=sum(X1.^2); SY1=sum(Y1.^2);
SX2=sum(X2.^2); SY2=sum(Y2.^2);
SXY1=sum(X1.*Y1); SXY2=sum(X2.*Y2);
r1=(SXY1-n*X1m.*Y1m)./(sqrt((SX1-n.*X1m.^2).*(SY1-n*Y1m.^2)));
r2=(SXY2-n*X2m.*Y2m)./(sqrt((SX2-n.*X2m.^2).*(SY2-n*Y2m.^2)));
z1=atanh(r1); 
z2=atanh(r2);
rl1=tanh(z1-norminv(0.975,z1,sqrt(1/(n-3)))*sqrt(1/(n-3)));
ru1=tanh(z1+norminv(0.975,z1,sqrt(1/(n-3)))*sqrt(1/(n-3)));
rl2=tanh(z2-norminv(0.975,z2,sqrt(1/(n-3)))*sqrt(1/(n-3)));
ru2=tanh(z2+norminv(0.975,z2,sqrt(1/(n-3)))*sqrt(1/(n-3)));
figure(1)
clf
hist(rl1)
ylabel('Frequency'); xlabel('ci'); title('Lower ci limit for rho=0')
figure(2)
clf
hist(ru1)
ylabel('Frequency'); xlabel('ci'); title('Upper ci limit for rho=0')
figure(3)
clf
hist(rl2)
ylabel('Frequency'); xlabel('ci'); title('Lower ci limit for rho=0.5')
figure(4)
clf
hist(ru2)
ylabel('Frequency'); xlabel('ci'); title('Upper ci limit for rho=0.5')
prl1=length(find(rl1>=0)); pru1=length(find(ru1<=0));
prl2=length(find(rl2>=0.5)); pru2=length(find(ru2<=0.5));
%prl2=length(find(rl2>0.25)); pru2=length(find(ru2<0.25)); %question d
fprintf('rho=0 is found in the CI at %.2f%%.\n',(prl1+pru1)/M*100) %θα επρεπε να ειναι 95
fprintf('rho=0.5 is found in the CI at %.2f%%.\n',(prl2+pru2)/M*100)
%question b
t1=r1.*sqrt((n-2)./(1-r1.^2));
t2=r2.*sqrt((n-2)./(1-r2.^2));
p1=(1-tcdf(t1,n-2))*2;
p2=(1-tcdf(t2,n-2))*2;
fprintf('The rho=0 hypothesis is rejected %.2f%% of the time for independent X,Y.\n',(length(find(p1<0.05)/M))/10)
fprintf('The rho=0 hypothesis is rejected %.2f%% of the time for codependant X,Y.\n',(length(find(p2<0.05)/M))/10)
