%question a
h1=100; h2=[60,54,58,60,56];
n=5; M=1000;
e_exp=0.76; e_calc=sqrt(h2/h1);
h=chi2gof(e_calc);
if h==0
    pre_err=sqrt(var(e_calc));
    acc_err=pre_err/sqrt(n);
    % η διασπορά είναι η ακριβεια και η ορθοτητα. Όταν θέλω την αβεβαιότητα
    % παιρνω το διάστημα εμπιστοσυνης
    fprintf("The uncertainty of accuracy is: +-%f \nThe uncertainty of precision is: +-%f \n",acc_err,pre_err)
else
    disp('The sample does not follow the normal distribution.')
end
%question b
test=zeros(1,M);
e_exp2=sqrt(58/h1);
% x=normrnd(58,2,[n,M]);
% e=sqrt(x./h1);
for i=1:M
    x=normrnd(58,2,[1,n]);
    m=mean(x); s=sqrt(var(x));
    e=sqrt(x/h1);
    me=mean(e); se=sqrt(var(e)); 
    if me>=(e_exp2-se) && me<=(e_exp2+se)
        test(i)=1;
    end
end
mtest=mean(test);
fprintf("The values are %.2f%% consistent with the expected value.\n",mtest*100)
%question c
h1=[80,100,90,120,95]; h2=[48,60,50,75,56];
sh1=sqrt(var(h1)); sh2=sqrt(var(h2));
fprintf("The uncertainty for h1 is %.3f and the uncertainty  for h2 is %.3f\n",sh1,sh2)
e=sqrt(h2./h1); m_e=mean(e); s_e=sqrt(var(e));
if e_exp>=(m_e-s_e) && e_exp<=(m_e+s_e)
    fprintf("We can accept that the ball is properly inflated.\n")
else
    fprintf("We can not accept that the ball is properly inflated.\n")
end