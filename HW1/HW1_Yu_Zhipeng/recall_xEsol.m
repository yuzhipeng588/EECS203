function [tEsol,xEsol]=recall_xEsol(k,TS)
cp = 1;
mz = 100;
cz = 20;
tEsol=zeros(k+1,1);
T=zeros(200,1);
for i=1:k+1
    if(i==1)
        T(i)=25;
        tEsol(i)=0;
    end
    if(i>1)
        u=UH((i-1)*TS);
        q=QH((i-1)*TS);
        T(i)=T(i-1)+TS*bldgHTM(T(i-1), u(1), u(2), q, mz, cz, cp);
        tEsol(i)=(i-1)*TS;
    end
end
xEsol=T;
plot(tEsol,xEsol);

end