% HW2
A1=[1,0;0,1];
b1=[0;-5];
Ainf=[1,0;0,1];
binf=[2;0];
Ac=[3,2;1,0;-1,0;0,1;0,-1];
bc=[-3;2;0;3;2];
[xOpt, J] = reg1Inf(A1, b1, Ainf, binf, Ac, bc);
double(xOpt)
double(J)
% HW3
p = sdpvar(2,1);
t1=sdpvar(1,1);
t2= sdpvar(2,1);
C1=(3*p(1)+2*p(2))<=-3;
C2=p(1)>=0;
C3=p(1)<=2;
C4=p(2)>=-2;
C5=p(2)<=3;
C6=[abs(p(1)-2)<=t1,t1>=0];
C7=abs(p(2))<=t1;
C8=[abs(p(1))<=t2(1),t2(1)>=0];
C9=[abs(p(2)+5)<=t2(2),t2(2)>=0];
C=[C1,C2,C3,C4,C5,C6,C7,C8,C9];
obj= t1+t2(1)+t2(2);
options = sdpsettings('verbose',1,'savesolveroutput',1);
out=optimize(C,obj,options);
out.solveroutput.LAMBDA
double(p);
double(obj)