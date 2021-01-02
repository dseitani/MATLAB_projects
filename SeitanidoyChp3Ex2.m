n=10;
x=sym('x',[1,n]);
syms tau f(tau,x)
f=(1/tau)*exp(-x/tau);
L=f.^n;
eq=diff(L,tau)==0;
sol=solve(eq);
disp(sol)

M=10000;
n=1000;
%1/τ πρεπει οχι τ, έτσι το ζητάει η άσκηση
t=2;
y=expo(M,n,t);
disp(y)

function [mo]=expo(M,n,t)
    r=exprnd(1/t,M,n);
    m=mean(r,2);
    figure('Name','Chapter 3 Exersice 2')
    clf
    hist(m)
    xlabel('Mean')
    ylabel('Frequency')
    title('Exponential Distibution')
    mo=mean(m);
end