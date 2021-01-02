data = importdata('sunspots.dat');
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

%period calculation
d = 12; 
S = zeros(d,1);
for i=1:d
    S(i) = mean(xt(i:d:n));
end
nper = floor(n/d);
st = repmat(S,nper,1);
if n>nper*d
    st(nper*d+1:n)=S(1:n-nper*d);
end
figure(3)
plot(t,st)
title('Period Diagram')

%remainders
yt = xt - st;
figure(4)
clf
plot(t,yt)
title('History Diagram (remainders)')
xlabel('t')
ylabel('y(t)')
figure(5)
clf
autocorr(yt)

%Conslusion: Periodic, we can't remove periodocity because the period is
%not exactly 11 yrs (maybe dymanic system) 
