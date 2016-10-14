function [xE, yE, vE, psiE] = bikeFEsim(aSeq, deltaFSeq, initState, TS)
N=length(aSeq);
xE=zeros(N+1,1);
yE=zeros(N+1,1);
vE=zeros(N+1,1);
psiE=zeros(N+1,1);
for i=1:N+1
    if(i==1)
        xE(i)=initState(1);
        yE(i)=initState(2);
        vE(i)=initState(3);
        psiE(i)=initState(4);
    end
    if(i>1)
        [xE(i), yE(i), vE(i), psiE(i)] = bikeFE(xE(i-1), yE(i-1), vE(i-1), psiE(i-1), aSeq(i-1), deltaFSeq(i-1), TS);
    end
end

end