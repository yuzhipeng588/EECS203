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




