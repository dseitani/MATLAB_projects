M = 100;
n = 40;

%import data
dat = importdata('forestfires.dat');
txt=["X","Y","month","day","FFMC","DMC","DC","ISI","temp","RH","rain","area"];
len = length(dat);

%stepwisefit for all the data
Y = dat(:,11);
X = [ones(len,1) dat(:,1:10) dat(:,12:13)];

[b,~,~,inmodel,stats] = stepwisefit(X,Y);
indX0 = find(inmodel==1);

indXi = zeros(M,length(txt));
for i=1:M
    %random sample
    indx = randperm(len,n);
    data = dat(indx,:);
    
    %stepwisefit for the random sample
    Y = data(:,11);
    X = [ones(n,1) data(:,1:10) data(:,12:13)];

    [b,~,~,inmodel,stats] = stepwisefit(X,Y);
    if isempty(inmodel)
        continue; 
    end
    temp = find(inmodel==1);
    for j=1:length(temp)
        indXi(i,j) = temp(j);
    end
    
end

%percentage of appearnce of X0 in random samples
perc = zeros(length(indX0),1);
for i=1:length(indX0)
    perc(i) = length(find(indX0(i)==indXi(:)));
    fprintf('For the variable %s: percentage of appearnce in random sample = %d%%\n',txt(indX0(i)),perc(i))
end

% Conclusion: the variables temp and RH appear more often that the others.
