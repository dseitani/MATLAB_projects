n = 100;
t = 1:n;
xt = zeros(n,1);
x0 = rand();
for i=1:n
   xt(i)= 4*x0*(1-x0);
   x0=xt(i);
end

figure(1)
clf
plot(t,xt)
title('History Diagram')
xlabel('t')
ylabel('x(t)')

figure(2)
clf
autocorr(xt)

%Conclusion: Chaotic