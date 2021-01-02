L=1000;
n=20;
mu=[0; 0];
sigma1=[1 1];
sigma2=[1 0.5; 0.5 1];
xy1=mvnrnd(mu,sigma1,n);
xy2=mvnrnd(mu,sigma2,n);
X1=(xy1(:,1));%.^2; 
Y1=(xy1(:,2));%.^2;
X2=(xy2(:,1));%.^2;
Y2=(xy2(:,2));%.^2;
X1m=mean(X1); Y1m=mean(Y1);
X2m=mean(X2); Y2m=mean(Y2);
SX1=sum(X1.^2); SY1=sum(Y1.^2);
SX2=sum(X2.^2); SY2=sum(Y2.^2);
SXY1=sum(X1.*Y1); SXY2=sum(X2.*Y2);
r1=(SXY1-n*X1m.*Y1m)./(sqrt((SX1-n.*X1m.^2).*(SY1-n*Y1m.^2)));
r2=(SXY2-n*X2m.*Y2m)./(sqrt((SX2-n.*X2m.^2).*(SY2-n*Y2m.^2)));
t01=r1.*sqrt((n-2)./(1-r1.^2));
t02=r2.*sqrt((n-2)./(1-r2.^2));
X1r=zeros(20,L); X2r=zeros(20,L);
t1=zeros(L,1); t2=zeros(L,1);
for i=1:L
   r=randperm(n);
   X1r(:,i)=X1(r);
   X2r(:,i)=X2(r); 
   X1m=mean(X1r(:,i)); X2m=mean(X2r(:,i));
   SX1=sum(X1r(:,i).^2); SX2=sum(X2r(:,i).^2); 
   SXY1=sum(X1r(:,i).*Y1); SXY2=sum(X2r(:,i).*Y2);
   r1=(SXY1-n*X1m.*Y1m)./(sqrt((SX1-n.*X1m.^2).*(SY1-n*Y1m.^2)));
   r2=(SXY2-n*X2m.*Y2m)./(sqrt((SX2-n.*X2m.^2).*(SY2-n*Y2m.^2)));
   t1(i)=r1.*sqrt((n-2)./(1-r1.^2));
   t2(i)=r2.*sqrt((n-2)./(1-r2.^2));
end
t1a=sort(t1); t2a=sort(t2);
a=0.05;
t1l=length(find(t1a(L*a/2:L*(1-a/2))>t01)/L); t1u=length(find(t1a(L*a/2:L*(1-a/2))<t01)/L);
t2l=length(find(t2a(L*a/2:L*(1-a/2))>t02)/L); t2u=length(find(t2a(L*a/2:L*(1-a/2))<t02)/L);
fprintf('The rho=0 hypothesis is not rejected %.2f%% of the time for independent X,Y.\n',(t1l+t1u)/L*100)
fprintf('The rho=0 hypothesis is not rejected %.2f%% of the time for codependant X,Y.\n',(t2l+t2u)/L*100)