n=100;
x=sym('x',[1,n]);
syms lamda f(lamda,x)
f=exp(-lamda)*(lamda.^x)/factorial(x);
L=f.^n;
eq=diff(L,lamda)==0;
sol=solve(eq);
disp(sol)

M=2000;
n=500;
l=0.1;
y=poisson(M,n,l);
disp(y)

function [mo]=poisson(M,n,l)
    r=poissrnd(l,M,n);
    m=mean(r,2);
    figure('Name','Chapter 3 Exersice 1')
    clf
    hist(m)
    xlabel('Mean')
    ylabel('Frequency')
    title('Poisson Distibution')
    mo=mean(m);
end
