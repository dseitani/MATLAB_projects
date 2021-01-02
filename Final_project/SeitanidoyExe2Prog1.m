M = 50;
n = 20;

%split data into burned (A) and unburned (B) 
data = importdata('forestfires.dat');
ind_A = find(data(:,13)==0);
dat_A = data(ind_A,:);
ind_B = find(data(:,13)~=0);
dat_B = data(ind_B,:);
na = length(dat_A);
nb = length(dat_B);
nabins = round(sqrt(na));
nbbins = round(sqrt(nb));


% ci for A,B
txt=["temp","RH","wind"];
ma = zeros(3,1); mb = zeros(3,1);
cia = zeros(3,2); cib = zeros(3,2);
for i=1:3 % 9:temp, 10:HR , 11:rain
    ma(i) = mean(dat_A(:,i+8));
    mb(i) = mean(dat_B(:,i+8));
    fprintf('Mean %s (A) = %.3f \n',txt(i),ma(i))
    fprintf('Mean %s (B) = %.3f \n',txt(i),mb(i))
    [~,~,cia(i,:)] = ttest(dat_A(:,i+8),ma(i));
    [~,~,cib(i,:)] = ttest(dat_B(:,i+8),mb(i));
    fprintf('ci %s (A) = [%.3f, %.3f] \n',txt(i),cia(i,1),cia(i,2))
    fprintf('ci %s (B) = [%.3f, %.3f] \n',txt(i),cib(i,1),cib(i,2))
    cil = abs(cia(i,1)-cib(i,1));
    ciu = abs(cia(i,2)-cib(i,2));
    fprintf('For %s : 95%% ci for difference of means = [%.3f, %.3f] \n',txt(i),cil,ciu)
  
    %random samples
    cisampA = zeros(M,2); cisampB = zeros(M,2); cisamp = zeros(M,2);
    for j=1:M
        indxA = randperm(na,n);
        indxB = randperm(nb,n);
        sampA = dat_A(indxA,i+8);
        sampB = dat_B(indxB,i+8);
        [~,~,cisampA(j,:)] = ttest(sampA,mean(sampA));
        [~,~,cisampB(j,:)] = ttest(sampB,mean(sampB));
        cisamp(j,1) = abs(cisampA(j,1)-cisampB(j,1));
        cisamp(j,2) = abs(cisampA(j,2)-cisampB(j,2));  
    end
    cisamp = sort(cisamp);
    fprintf('For %s : ci for difference of means from sampling = [%.3f, %.3f] \n',txt(i),cisamp(round(M*0.025),1),cisamp(round(M*(1-0.025)),2))


    figure(i)
    clf
    hist(cisampA,nabins)
    xlabel('CI low and upper limit')
    ylabel('Frequency')
    hold on
    ax = axis;
    plot(cia(i,1)*[1 1],[ax(3) ax(4)],'r')
    t=[num2str(cia(i,1)),'\rightarrow'];
    text(cia(i,1),11,t,'HorizontalAlignment','right')
    plot(cia(i,2)*[1 1],[ax(3) ax(4)],'g')
    t=['\leftarrow',num2str(cia(i,2))];
    text(cia(i,2),11,t,'HorizontalAlignment','left')    
    legend('CI low','CI upper','low all','upper all')
    title(sprintf('CI(%s) from random sampling from A with limits from all the data',txt(i)))
    
    figure(i+10)
    clf
    hist(cisampB,nbbins)
    xlabel('CI low and upper limit')
    ylabel('Frequency')
    hold on
    ax = axis;
    plot(cib(i,1)*[1 1],[ax(3) ax(4)],'r')
    t=[num2str(cib(i,1)),'\rightarrow'];
    text(cib(i,1),11,t,'HorizontalAlignment','right')
    plot(cib(i,2)*[1 1],[ax(3) ax(4)],'g')
    t=['\leftarrow',num2str(cib(i,2))];
    text(cib(i,2),11,t,'HorizontalAlignment','left')    
    legend('CI low','CI upper','low all','upper all')
    title(sprintf('CI(%s) from random sampling from B with limits from all the data',txt(i)))
end

% Conclusion: The small samples seem to aggree with the ci we calculated
% from all the data.
