%% Problem 5
%% 5(a)
TS = 0.2;
N = 70;
TFinal = TS*N;
lr=1.738;
lf=lr;
x=sdpvar(N+1,1);
y=sdpvar(N+1,1);
v=sdpvar(N+1,1);
psi=sdpvar(N+1,1);
a=sdpvar(N+1,1);
beta=sdpvar(N+1,1);
z = [x,y,v,psi];
zref=[0, 0, 0,-1*pi/2];
Cinit=z(1,:)==[0,3,0,0];
Cfinal=z(N+1,:)==[0,0,0,-1*pi/2];
CIE=[abs(a(N+1))<=1.5*TS,abs(beta(N+1))<=0.6];
CE=[Cinit,Cfinal];
for i=1:N
    CIE=[CIE;
        [-20,-5,-10,-2*pi] <= z(i,:)<=[20,10,10,2*pi];
        abs(a(i))<=1.5*TS;
        abs(beta(i))<=0.6;
        abs(beta(i+1)-beta(i))<=0.2
        ];
    CE=[CE;
        %z(i+1)==z(i)+TS*[v(i)*cos(psi(i)+beta(i)),v(i)*sin(psi(i)+beta(i)),a(i),(v(i)/lr)*sin(beta(i))];
        x(i+1) == x(i) + TS*v(i)*cos(psi(i) + beta(i));
        y(i+1) == y(i) + TS*v(i)*sin(psi(i) + beta(i));
        v(i+1) == v(i) + TS*a(i);
        psi(i+1) == psi(i) + TS*v(i)/1.738*sin(beta(i));
        ];       
end
C=[CIE,CE];
obj=norm(z(N+1,:)-zref)^2+norm(z(N-1,:)-zref)^2+norm(z(N,:)-zref)^2;
options = sdpsettings('verbose','IPOPT','savesolveroutput',1);
optimize(C,obj,options);
%out=optimize(C,obj,options);

xopt=double(x);
yopt=double(y);
vopt=double(v);
psiopt=double(psi);
aopt=double(a);
betaopt=double(beta);

T=(1:(N+1)).*TS;
figure
subplot(2,2,1)
plot(T,xopt)
xlabel('time')
ylabel('x_opt')
subplot(2,2,2)
plot(T,yopt)
xlabel('time')
ylabel('y_opt')
subplot(2,2,3)
plot(T,vopt)
xlabel('time')
ylabel('v_opt')
subplot(2,2,4)
plot(T,psiopt)
xlabel('time')
ylabel('psi_opt')
figure
plot(xopt,yopt)
xlabel('x')
ylabel('y')
axis equal