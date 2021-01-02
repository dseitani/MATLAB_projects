%split data into burned (A) and unburned (B) 
data = importdata('forestfires.dat');
ind_A = find(data(:,13)==0);
dat_A = data(ind_A,:);
ind_B = find(data(:,13)~=0);
dat_B = data(ind_B,:);
nabins = round(sqrt(length(dat_A)));
nbbins = round(sqrt(length(dat_B)));

% 9:temp, 10:RH , 11:wind
for i=9:11
    %histogram A,B for each index 
    [Nya,Xya] = hist(dat_A(:,i),nabins);
    [Nyb,Xyb] = hist(dat_B(:,i),nbbins);
    figure(i)
    clf
    bar(Xya,Nya/length(dat_A))
    hold on
    bar(Xyb,Nyb/length(dat_B))
    legend('A','B')
    %goodness of fit test, normal and poisson
    hna = chi2gof(dat_A(:,i));
    hnb = chi2gof(dat_B(:,i));
    pda = fitdist(dat_A(:,i),'Poisson');
    pdb = fitdist(dat_B(:,i),'Poisson');
    hpa = chi2gof(dat_A(:,i),'CDF',pda);
    hpb = chi2gof(dat_B(:,i),'CDF',pdb);
    if hna == 0
        fprintf('The distribution of index %d is normal for A\n',i)
    else
        fprintf('The distribution of index %d is not normal for A\n',i)
        if hpa == 0
        fprintf('The distribution of index %d is poisson for A\n',i)
        else
        fprintf('The distribution of index %d is not poisson for A\n',i)
        end
    end
    if hnb == 0
        fprintf('The distribution of index %d is normal for B\n',i)
    else
        fprintf('The distribution of index %d is not normal for B\n',i)
        if hpb == 0
        fprintf('The distribution of index %d is poisson for B\n',i)
        else
        fprintf('The distribution of index %d is not poisson for B\n',i)
        end
    end    
end

%from the histograms we see that the distribution for temp and HR are close for A
%and B, while for rain it shows a big difference.