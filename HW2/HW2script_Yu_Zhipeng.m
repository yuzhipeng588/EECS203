%% ME C231A, EECS C220B, Problem Set #1, OPT1
% Follow this format to organize the script file which "manages" all of the
% tasks in producing HW1.  Conclude by *publishing* this file, and then
% printing the resulting html file to pdf.  Turn the pdf file
% (electronically) in via bCourses (more instructions later).

%% Problem 1
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
fprintf('Unbounded,KKT is notsatisfied');
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
fprintf('KKT is notsatisfied');
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
fprintf('KKT is notsatisfied');
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
%out.solveroutput.LAMBDA
double(p);
double(obj)
fprintf('KKT is satisfied');
%----------------------------------------------------------------------------
%----------------------------------------------------------------------------
%% Problem 2
%% HW2
A1=[1,0;0,1];
b1=[0;-5];
Ainf=[1,0;0,1];
binf=[2;0];
Ac=[3,2;1,0;-1,0;0,1;0,-1];
bc=[-3;2;0;3;2];
[xOpt, J] = reg1Inf(A1, b1, Ainf, binf, Ac, bc);
double(xOpt)
double(J)
%% HW 3
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
%----------------------------------------------------------------------------
%----------------------------------------------------------------------------
%% Problem 3
%% 3(a)
p = sdpvar(2,1);
%u=sdpvar(4,1);
C1=abs(p(1))-1<=0;
C2=abs(p(2))-1<=0;
%KKT
%C5=-5+u(1)*(-3)+u(2)*(-2)+u(3)*(-1);
%C6=-7+u(1)*(2)+u(2)*(1)+u(4)*(-1);
%C7=-1*u<=0;
%C=[C1,C2,C3,C4,C5,C6,C7];
C=[C1,C2];
%obj= 3*sin(-2*pi*p(1))+2*p(1)+4+cos(2*pi*p(2))+p(2)+u(1)*(-3*p(1)+2*p(2)-30)+u(2)*(-2*p(1)+p(2)-12)+u(3)*-1*p(1)+u(4)*-1*p(2);
obj=3*sin(-2*pi*p(1))+2*p(1)+4+cos(2*pi*p(2))+p(2);
options = sdpsettings('verbose',1,'savesolveroutput',1);
%options = sdpsettings('verbose', 'bnb', 'bnb.solver', 'fmincon');
out=optimize(C,obj,options);
out.solveroutput.lambda
d=double(p);
double(obj)
%double(u)
% ans [0.2331;-0.5254]
fprintf('KKT is satisfied');
%% 3(b)
%3D plot
[X,Y] = meshgrid(-1:.02:1, -1:.02:1);
Z =3*sin(-2*pi*X) + 2*X + 4 + cos(2*pi*Y) + Y;
mesh(X,Y,Z)
figure
hold on;
contour(X,Y,Z,10,'ShowText','on')
plot(0.5,-1,'dr');
plot(d(1),d(2),'dr');
hold off;
figure

%% 3(c)
for i=1:20
p = sdpvar(2,1);
pint = 2*rand(2,1)-1;
assign(p, pint);
%u=sdpvar(4,1);
%KKT
%C5=-5+u(1)*(-3)+u(2)*(-2)+u(3)*(-1);
%C6=-7+u(1)*(2)+u(2)*(1)+u(4)*(-1);
%C7=-1*u<=0;
%C=[C1,C2,C3,C4,C5,C6,C7];
C =-(1+p(1)^2)^2+p(2)^2==4;
%obj= 3*sin(-2*pi*p(1))+2*p(1)+4+cos(2*pi*p(2))+p(2)+u(1)*(-3*p(1)+2*p(2)-30)+u(2)*(-2*p(1)+p(2)-12)+u(3)*-1*p(1)+u(4)*-1*p(2);
obj=log(1+p(1)^2)-p(2);
options = sdpsettings('usex0',1);
optimize(C,obj,options);
P(:,i)=double(p);
end
[X,Y] = meshgrid(-1000:1:1000, -1000:1:1000);
Z =log(1+X^2)-Y;
figure
hold on;
contour(X,Y,Z,'ShowText','on')
for i=1:20
plot(P(1,i),P(2,i),'dr');
end
hold off;

%----------------------------------------------------------------------------
%----------------------------------------------------------------------------
%% Problem 4
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
%% Problem 5

%% Attribution
% Include you name, date and the class number.
% Zhipeng Yu ,2016/9/16 ME231A
fprintf('Zhipeng Yu ,2016/9/16 ME231A');
