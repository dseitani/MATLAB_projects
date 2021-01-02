data = importdata('crutem3nh.dat');
t = data(:,1);
xt = data(:,2);
n = length(xt);

%history diagram
figure(1)
clf
plot(t,xt)
title('History Diagram')
xlabel('t')
ylabel('x(t)')

%autocorrelation diagram
figure(2)
clf
autocorr(xt);

%trend calculation
mt1 = polyfit(t,xt,1);
mt2 = polyfit(t,xt,2);
mt3 = polyfit(t,xt,3);
xt1 = xt - polyval(mt1,t);
xt2 = xt - polyval(mt2,t);
xt3 = xt - polyval(mt3,t);

figure(3)
clf
plot(t,xt1)
title('History Diagram, 1rst order')
xlabel('t')
ylabel('detrended xt')

figure('Name','1rst order')
clf
autocorr(xt1)

figure(5)
clf
plot(t,xt2)
title('History Diagram, 2nd order')
xlabel('t')
ylabel('detrended xt')

figure('Name','2nd order')
clf
autocorr(xt2)

figure(7)
clf
plot(t,xt3)
title('History Diagram, 3rd order')
xlabel('t')
ylabel('detrended xt')

figure('Name','3rd order')
autocorr(xt3)

%Conclusion: no/weak periodicity, we can't exclude the trend

yt = diff(xt);
yt(n) = xt(n);
figure(9)
clf
plot(t,yt)
title('History Diagram, first differences')
xlabel('t')
ylabel('y(t)')

figure(10)
clf
autocorr(yt)

%Now we see periodicity in the data, the trend has been excluded.