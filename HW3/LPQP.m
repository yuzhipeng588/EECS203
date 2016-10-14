%% 1(1)
p = sdpvar(2,1);
%u=sdpvar(4,1);
C1=(-3*p(1)+2*p(2)-30)<=0;
C2=(-2*p(1)+p(2)-12)<=0;
C3=-1*p(1)<=0;
C4=-1*p(2)<=0;
%KKT
%C5=-5+u(1)*(-3)+u(2)*(-2)+u(3)*(-1);
%C6=-7+u(1)*(2)+u(2)*(1)+u(4)*(-1);
%C7=-1*u<=0;
%C=[C1,C2,C3,C4,C5,C6,C7];
C=[C1,C2,C3,C4];
%obj= -5*p(1)-7*p(2)+u(1)*(-3*p(1)+2*p(2)-30)+u(2)*(-2*p(1)+p(2)-12)+u(3)*-1*p(1)+u(4)*-1*p(2);
obj=-5*p(1)-7*p(2);
%options = sdpsettings('verbose', 'bnb', 'bnb.solver', 'fmincon');
options = sdpsettings('verbose',1,'savesolveroutput',1);
out=optimize(C,obj,options);
out.solveroutput.LAMBDA
double(p);
double(obj)
%double(u)
% unbounded , KKT is notsatisfied
%% 1(2)
p = sdpvar(2,1);
C1=(p(1)-p(2))<=1;
C2=(3*p(1)+2*p(2))<=12;
C3=(2*p(1)+3*p(2))<=3;
C4=(-2*p(1)+3*p(2))>=9;
C5=p(1)>=0;
C6=p(2)>=0;
C=[C1,C2,C3,C4,C5,C6];

obj= 3*p(1)+p(2);
options = sdpsettings('verbose',1,'savesolveroutput',1);
out=optimize(C,obj,options);
out.solveroutput.LAMBDA
double(p);
double(obj)
%KKT is satisfied
%% 1(3)
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
%KKT is satisfied
%% 1(4)
p = sdpvar(2,1);
t1=sdpvar(1,1);
t2= sdpvar(2,1);
C1=p(1)<=-3;
C2=p(2)<=4;
C3=(4*p(1)+3*p(2))<=0;
C=[C1,C2,C3];
obj= p(1)^2+p(2)^2;
options = sdpsettings('verbose',1,'savesolveroutput',1);
out=optimize(C,obj,options);
out.solveroutput.LAMBDA
double(p);
double(obj)
%KKT is not satisfied