B = 1000;

%import data
dat = importdata('forestfires.dat');
txt=["FFMC","DMC","DC","ISI","temp","RH","wind"];
low = round(B*0.025);
upp =round(B*(1-0.025));
n=length(txt);
len = length(dat);
fprintf('Ho hypothesis: rho=0\n \n')

%random sample
indx = randperm(len,40);
data = dat(indx,:);
m = length(data);

%parametric test for Ho hypothesis r=0
for i=1:n
    X = data(:,i+4);
    for j=i+1:n
        Y = data(:,j+1);
        r = corrcoef(X,Y);
        tstat = r(1,2).*sqrt((m-2)./(1-r(1,2).^2));
        tcrit = tinv(1-0.025,m-2);
        if abs(tstat)>tcrit
            fprintf('Parametric test: Ho is rejected for %s and %s.\n',txt(i),txt(j))
        else
            fprintf('Parametric test: Ho is not rejected for %s and %s.\n',txt(i),txt(j))
        end
        
        %non-parametric test for Ho hypothesis r=0
        rran = zeros(B,1);
        for k=1:B
            ran = randperm(m);
            Yrand = Y(ran);
            r = corrcoef(X,Yrand);
            rran(k) = r(1,2);
        end
        tran = rran.*sqrt((m-2)./(1-rran.^2));
        tran = sort(tran);
        if tran(low)<=abs(tstat) && abs(tstat)>=tran(upp)
            fprintf('Non-parametric test: Ho is rejected for %s and %s.\n',txt(i),txt(j))
        else
            fprintf('Non-parametric test: Ho is not rejected for %s and %s.\n',txt(i),txt(j))
        end        
        fprintf('\n')
    end
end

% Conclusion: The two different tests seem to agree.