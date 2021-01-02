M = 50;
n = 20;
B = 1000;

%split data into burned (A) and unburned (B) 
data = importdata('forestfires.dat');
ind_A = find(data(:,13)==0);
dat_A = data(ind_A,:);
ind_B = find(data(:,13)~=0);
dat_B = data(ind_B,:);
nabins = round(sqrt(length(dat_A)));
nbbins = round(sqrt(length(dat_B)));
txt={'temp','RH','wind'};
n1 = length(dat_A);
n2 = length(dat_B);
nall = n1+n2;
low = round(B*0.025);
upp =round(B*(1-0.025));
fprintf('Ho hypothesis: median(A)== median(B)\n')

% test hypothesis for all the data
mdA = zeros(3,1); mdB = zeros(3,1);
for i=1:3 % 9:temp, 10:HR , 11:rain
    mdA(i) = median(dat_A(:,i+8));
    mdB(i) = median(dat_B(:,i+8));
    fprintf('Median (A) for %s : %.4f\n',txt{i},mdA(i))
    fprintf('Median (B) for %s : %.4f\n',txt{i},mdB(i))
    rmdA = zeros(B,1); rmdB = zeros(B,1);
    for j=1:B
        r = randperm(nall);
        randat = data(r,:);
        ranA = randat(1:n1,i+8);
        ranB = randat(n1+1:end,i+8);
        rmdA(j) = median(ranA);
        rmdB(j) = median(ranB);
    end
    rmdA = sort(rmdA);
    rmdB = sort(rmdB);
    if rmdA(low)<=mdB(i) && mdB(i)>=rmdA(upp)
        fprintf('Ho hypothesis not rejected for %s\n',txt{i})
    else
        fprintf('Ho hypothesis rejected for %s\n',txt{i})
    end
    
    %test hypothesis for random samples
    medA = zeros(M,1); medB = zeros(M,1); perc = zeros(M,1);
    for j=1:M
        indxA = randperm(n1,n);
        indxB = randperm(n2,n);
        sampA = dat_A(indxA,i+8);
        sampB = dat_B(indxB,i+8);
        sampall = [sampA; sampB];
        medA(j) = median(sampA);
        medB(j) = median(sampB);
        rmdA = zeros(B,1); rmdB = zeros(B,1);
        for k=1:B
            r = randperm(length(sampA)+length(sampB));
            randat = sampall(r,:);
            ranA = randat(1:n);
            ranB = randat(n+1:end);
            rmdA(k) = median(ranA);
            rmdB(k) = median(ranB);
        end
        rmdA = sort(rmdA);
        rmdB = sort(rmdB);
        perc(j) = length(find(rmdA(low)<=medB(j) && medB(j)>=rmdA(upp)));
    end
    fprintf('The percentage in with Ho is not rejected for %s for the %d random samples is: %.3f\n',txt{i},M,sum(perc)/M*100)
    fprintf('\n')
end

% Conclusion: the results regurding the Ho hypothesis do not agree between
% the two methods.
