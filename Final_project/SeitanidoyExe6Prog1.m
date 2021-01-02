B = 1000;
M = 100;
n = 40;

%import data
dat = importdata('forestfires.dat');
%9:temp, 10:RH
len = length(dat);
low = round(B*0.025);
upp =round(B*(1-0.025));

%beta calculation
beta = regress(dat(:,10),[ones(len,1) dat(:,9)]);

b = zeros(M,2); bint = zeros(M,4); bintboo = zeros(M,4);
for i=1:M
    %random sample
    indx = unidrnd(len,n,1);
    data = dat(indx,:);
    m = length(data);

    %regression RH-temp
    X = [ones(m,1) data(:,9)];
    Y = data(:,10);
    [b(i,:),~,r] = regress(Y,X);
    se = sqrt((1/(n-2))*(sum((r).^2)));
    Sxx = var(data(:,9))*(n-1);
    Xm = mean(data(:,9));
    bint(i,1) = b(i,1)-tinv(0.975,n-2)*se*sqrt(1/n+Xm^2/Sxx);
    bint(i,2) = b(i,1)+tinv(0.975,n-2)*se*sqrt(1/n+Xm.^2/Sxx);
    bint(i,3) = b(i,2)-tinv(0.975,n-2)*se/sqrt(Sxx);
    bint(i,4) = b(i,2)+tinv(0.975,n-2)*se/sqrt(Sxx);
    
    %Bootstrap method
    bboo = zeros(B,2); 
    for j=1:B
        ind = unidrnd(n,n,1);
        datboo = data(ind,:);
        Xboo = [ones(m,1) datboo(:,9)];
        Yboo = datboo(:,10);
        [bboo(j,:),~,r] = regress(Yboo,Xboo);
    end
    bboo = sort(bboo);
    bintboo(i,1) = bboo(low,1);
    bintboo(i,2) = bboo(upp,1);
    bintboo(i,3) = bboo(low,2);
    bintboo(i,4) = bboo(upp,2);
end

nbins = round(length(bint));

% percentage of beta in ci parametric
percparb0 = length(find(bint(:,1)<beta(1) | beta(1)>bint(:,2)));
percparb1 = length(find(bint(:,3)<beta(2) | beta(2)>bint(:,4)));
fprintf('Perentage in which beta0 is in parametric CI for b0: %d%%\n',percparb0)
fprintf('Perentage in which beta1 is in parametric CI for b1: %d%%\n',percparb1)
fprintf('\n')

% percentage of beta in ci bootstrap
percboob0 = length(find(bintboo(:,1)<beta(1) | beta(1)>bintboo(:,2)));
percboob1 = length(find(bintboo(:,3)<beta(2) | beta(2)>bintboo(:,4)));
fprintf('Perentage in which beta0 is in bootstrap CI for b0: %d%%\n',percboob0)
fprintf('Perentage in which beta1 is in bootstrap CI for b1: %d%%\n',percboob1)

%Histograms
figure(1)
clf
hist(bint(:,[1 2]),nbins)
xlabel('b0')
ylabel('Frequency')
title('CI for b0 (parametric method)')
hold on
ax = axis;
plot(beta(1)*[1 1],[ax(3) ax(4)],'g')
legend('Lower limit','Upper limit')

figure(2)
clf
hist(bint(:,[3 4]),nbins)
xlabel('b1')
ylabel('Frequency')
title('CI for b1 (parametric method)')
hold on
ax = axis;
plot(beta(2)*[1 1],[ax(3) ax(4)],'g')
legend('Lower limit','Upper limit')

figure(3)
clf
hist(bintboo(:,[1 2]),nbins)
xlabel('b0')
ylabel('Frequency')
title('CI for b0 (bootstrap method)')
hold on
ax = axis;
plot(beta(1)*[1 1],[ax(3) ax(4)],'g')
legend('Lower limit','Upper limit')

figure(4)
clf
hist(bintboo(:,[3 4]),nbins)
xlabel('b1')
ylabel('Frequency')
title('CI for b1 (bootstrap method)')
hold on
ax = axis;
plot(beta(2)*[1 1],[ax(3) ax(4)],'g')
legend('Lower limit','Upper limit')