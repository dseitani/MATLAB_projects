n=39;
X=importdata('tempThess57_97.dat');
Y=importdata('rainThess57_97.dat');
Xm=mean(X); 
Ym=mean(Y);
SX=sum(X.^2); 
SY=sum(Y.^2);
SXY=sum(X.*Y);
r=(SXY-n*Xm.*Ym)./(sqrt((SX-n.*Xm.^2).*(SY-n*Ym.^2)));
t0=r.*sqrt((n-2)./(1-r.^2));
p0=(1-tcdf(t0,n-2))*2;
month=["January","February","March","April","May","June","July","August","September","October","November","December"];
for i=1:12
    fprintf('The p-value is %.4f for %s.\n',p0(i),month(i))
end
L=1000;
Xr=zeros(n,L); 
t=zeros(L,12);
for i=1:L
   r=randperm(n);
   Xr(:,i)=X(r);
   Xrm=mean(Xr(:,i));
   SXr=sum(Xr(:,i).^2); 
   SXrY=sum(Xr(:,i).*Y);
   r=(SXY-n*Xrm.*Ym)./(sqrt((SXr-n.*Xrm.^2).*(SY-n*Ym.^2)));
   t(i,:)=r.*sqrt((n-2)./(1-r.^2));
end
ta=sort(t);
tl=zeros(1,12); tu=zeros(1,12);
a=0.05;
for i=1:12
    tl=length(find(ta(L*a/2:L*(1-a/2),i)>t0)/L); tu=length(find(ta(L*a/2:L*(1-a/2),i)<t0)/L);
    fprintf('The rho=0 hypothesis is not rejected %.1f%% for %s.\n',(tl+tu)/L,month(i))
end