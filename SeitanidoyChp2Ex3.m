%Για να χρησιμοποιήσω την mvnrnd πρέπει να δώσω τα μ(mu) και σ^2(sigma) για τις
%μεταβλητές Χ και Υ
mu=rand(1,2);
rho=0.9; %διορθωση
sigma=[1 rho; rho 1]; %διορθωση
%sigma=10*eye(2);
r=mvnrnd(mu,sigma,100000);
X=r(1:100000,1);
Y=r(1:100000,2);
varall=var(X+Y);
varX=var(X);
varY=var(Y);
if varall~=varX+varY
    disp('Δεν ισχύει η ιδιοτητα Var[X+Y]=Var[X]+Var[Y]')
end