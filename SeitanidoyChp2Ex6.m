n=100;
N=10000;
X=rand([n,N]);
Y=mean(X); %returns a row vector containing the mean of each column
figure('Name','CLT')
clf
histfit(Y)
xlabel('Y')
ylabel('Frequency')
title('Central Limit Theorem')