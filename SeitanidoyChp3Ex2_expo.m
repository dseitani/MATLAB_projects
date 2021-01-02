function [m]=SeitanidoyChp3Ex2_expo(M,n,t)
    bins=round(sqrt(M/5));
    r=exprnd(1/t,n,M);
    m=mean(r);
    nam=['n=',num2str(n)];
    figure('Name',nam)
    clf
    hist(m,bins)
    xlabel('Mean')
    ylabel('Frequency')
    title('Exponential Distibution')
     %mo=mean(m);