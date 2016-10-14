%% 4(a)
p = intvar(2,1);
C1=(p(1)+4*p(2)-16)<=0;
C2=(6*p(1)+4*p(2)-28)<=0;
C3=(2*p(1)-5*p(2)-6)<=6;
C4=p(1)<=10;
C5=p(2)<=10;
C=[C1,C2,C3,C4,C5,p(1)>=0,p(2)>=0];
obj=-6*p(1)-5*p(2);
options = sdpsettings('verbose', 'bnb', 'bnb.solver', 'fmincon');
optimize(C,obj,options);
double(p)
double(obj)

%% 4(b)
p=sdpvar(2,1);
b=binvar(1,1);
obj=-1*p(1)-2*p(2);
C1=(1-b)*(3*p(1)+4*p(2)-12)<=0;
C2=b*(4*p(1)+3*p(2)-12)<=0;
C=[C1,C2,p(1)>=0,p(2)>=0];
options = sdpsettings('verbose', 'bnb', 'bnb.solver', 'fmincon');
optimize(C,obj,options);
double(p)
double(obj)