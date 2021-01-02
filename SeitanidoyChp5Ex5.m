n=100;
M=1000;
bins=round(sqrt(M));
data=importdata('lightair.dat');
b1=zeros(M,1); b0=zeros(M,1);
for i=1:M
    index=unidrnd(n,n,1);
    rand_data((1:n),:)=data(index((1:n)),:);
    air=rand_data(:,1);
    light=rand_data(:,2);
    X=mean(air); Y=mean(light);
    sx=var(air); sy=var(light); sxy=cov(air,light);
    b1(i,1)=sxy(1,2)/sx;
    b0(i,1)=Y-b1(i,1)*X;
end
b1_s=sort(b1);
b0_s=sort(b0);
low=0.025*M; up=0.975*M;
b1_low=b1_s(low); b1_up=b1_s(up);
b0_low=b0_s(low); b0_up=b0_s(up);
figure(1)
clf
hist(b1_s,bins)
hold on
xlabel('b1')
ylabel('Frequency')
title('Bootstrap CI for b1')
a=axis;
plot([b1_low b1_low],[a(3) a(4)],'g')
txt=[num2str(b1_low),'\rightarrow'];
text(b1_low,70,txt,'HorizontalAlignment','right')
plot([b1_up b1_up],[a(3) a(4)],'g')
txt=['\leftarrow ',num2str(b1_up)];
text(b1_up,70,txt)
hold off
figure(2)
clf
hold on
hist(b0_s,bins)
xlabel('b0')
ylabel('Frequency')
title('Bootstrap CI for b0')
a=axis;
plot([b0_low b0_low],[a(3) a(4)],'g')
txt=[num2str(b0_low),'\rightarrow'];
text(b0_low,70,txt,'HorizontalAlignment','right')
plot([b0_up b0_up],[a(3) a(4)],'g')
txt=['\leftarrow ',num2str(b0_up)];
text(b0_up,70,txt)
hold off
fprintf('The parametric CI for b1: [-1183.755,1048.643]\n')
fprintf('The parametric CI for b0: [-340.728,1924.613]\n')