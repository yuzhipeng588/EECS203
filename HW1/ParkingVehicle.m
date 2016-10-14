%%
lr = 1.738;
lf = 1.738;
nx = 4;
nu = 2;
N = 71;
TS = 0.2;
zRef = [0;0;0;-pi/2];
fDyn = @(z,u) [z(3)*cos(z(4)+u(2));z(3)*sin(z(4)+u(2));u(1);z(3)/lr*sin(u(2))];
objJ = @(zSeq,uSeq) norm(zSeq(:,end-2)-zRef)^2+norm(zSeq(:,end-1)-zRef)^2+norm(zSeq(:,end)-zRef)^2;
cIE = @(zSeq,uSeq) [zSeq(1,:)'-20;zSeq(2,:)'-10;zSeq(3,:)'-10;zSeq(4,:)'-2*pi;...
       -zSeq(1,:)'-20;-zSeq(2,:)'-5;-zSeq(3,:)'-10;-zSeq(4,:)'-2*pi;...
       uSeq(1,:)'-1.5;-uSeq(1,:)'-1.5;uSeq(2,:)'-0.6;-uSeq(2,:)'-0.6;...
       uSeq(2,2:end)'-uSeq(2,1:end-1)'-0.2;-uSeq(2,2:end)'+uSeq(2,1:end-1)'-0.2];
cE = @(zSeq,uSeq) [zSeq(:,1) - [0;3;0;0];zSeq(:,end)-[0;0;0;-pi/2]];
parm.fh = fDyn;
parm.ts = TS;
parm.nu = nu;
parm.nx = nx;
parm.x0 = [0;3;0;0];
parm.Jh = objJ;
parm.cIEh = cIE;
parm.cEh = cE;
nDV = parm.nu*N;
dvInit = randn(nDV,1);
fmcOBJ = @(dv) fminconDynamicSystemTemplate(dv,parm,'obj');
fmcCON = @(dv) fminconDynamicSystemTemplate(dv,parm,'constraint');
options = optimoptions('fmincon','MaxFunctionEvaluations',20000,'display','iter');
[uDV, FVAL, EXITFLAG, OUTPUT, LAMBDA, GRAD] = fmincon(fmcOBJ,dvInit,...
[],[],[],[],[],[],fmcCON,options);
uSeq = reshape(uDV,[nu,N]);
zSeq = zeros(nx,N);
zSeq(:,1) = parm.x0;
for i = 1:N-1
    zSeq(:,i+1) = zSeq(:,i) + TS*fDyn(zSeq(:,i),uSeq(:,i));
end
clf
subplot(4,1,1)
plot(TS:TS:TS*N,zSeq(1,:),'g')
xlabel('Sample Time(sec)')
ylabel('x coordinate')
subplot(4,1,2)
plot(TS:TS:TS*N,zSeq(2,:),'r')
xlabel('Sample Time(sec)')
ylabel('y coordinate')
subplot(4,1,3)
plot(TS:TS:TS*N,zSeq(3,:),'b')
xlabel('Sample Time(sec)')
ylabel('Speed of vehicle')
subplot(4,1,4)
plot(TS:TS:TS*N,zSeq(4,:),'p')
xlabel('Sample Time(sec)')
ylabel('heading angle')
%%
lr = 1.738;
lf = 1.738;
nx = 4;
nu = 2;
N = 71;
TS = 0.2;
zRef = [0;0;0;-pi/2];
fDyn = @(z,u) [z(3)*cos(z(4)+u(2));z(3)*sin(z(4)+u(2));u(1);z(3)/lr*sin(u(2))];
objJ = @(zSeq,uSeq) norm(zSeq(:,end-2)-zRef)^2+norm(zSeq(:,end-1)-zRef)^2+norm(zSeq(:,end)-zRef)^2
cIE = @(zSeq,uSeq) [zSeq(1,:)'-20;zSeq(2,:)'-10;zSeq(3,:)'-10;zSeq(4,:)'-2*pi;...
       -zSeq(1,:)'-20;-zSeq(2,:)'-0.2;-zSeq(3,:)'-10;-zSeq(4,:)'-2*pi;...
       uSeq(1,:)'-1.5;-uSeq(1,:)'-1.5;uSeq(2,:)'-0.6;-uSeq(2,:)'-0.6;...
       uSeq(2,2:end)'-uSeq(2,1:end-1)'-0.2;-uSeq(2,2:end)'+uSeq(2,1:end-1)'-0.2];
cE = @(zSeq,uSeq) [zSeq(:,1) - [0;3;0;0];zSeq(:,end)-[0;0;0;-pi/2]];
parm.fh = fDyn;
parm.ts = TS;
parm.nu = nu;
parm.nx = nx;
parm.x0 = [0;3;0;0];
parm.Jh = objJ;
parm.cIEh = cIE;
parm.cEh = cE;
nDV = parm.nu*N;
dvInit = randn(nDV,1);
fmcOBJ = @(dv) fminconDynamicSystemTemplate(dv,parm,'obj');
fmcCON = @(dv) fminconDynamicSystemTemplate(dv,parm,'constraint');
options = optimoptions('fmincon','MaxFunctionEvaluations',20000,'display','iter');
[uDV, FVAL, EXITFLAG, OUTPUT, LAMBDA, GRAD] = fmincon(fmcOBJ,dvInit,...
[],[],[],[],[],[],fmcCON,options);
uSeq = reshape(uDV,[nu,N]);
zSeq = zeros(nx,N);
zSeq(:,1) = parm.x0;
for i = 1:N-1
    zSeq(:,i+1) = zSeq(:,i) + TS*fDyn(zSeq(:,i),uSeq(:,i));
end
clf
subplot(4,1,1)
plot(TS:TS:TS*N,zSeq(1,:),'g')
xlabel('Sample Time(sec)')
ylabel('x coordinate')
subplot(4,1,2)
plot(TS:TS:TS*N,zSeq(2,:),'r')
xlabel('Sample Time(sec)')
ylabel('y coordinate')
subplot(4,1,3)
plot(TS:TS:TS*N,zSeq(3,:),'b')
xlabel('Sample Time(sec)')
ylabel('Speed of vehicle')
subplot(4,1,4)
plot(TS:TS:TS*N,zSeq(4,:),'p')
xlabel('Sample Time(sec)')
ylabel('heading angle')
%%
lr = 1.738;
lf = 1.738;
nx = 4;
nu = 2;
N = 71;
TS = 0.2;
zRef = [0;0;0;-pi/2];
fDyn = @(z,u) [z(3)*cos(z(4)+u(2));z(3)*sin(z(4)+u(2));u(1);z(3)/lr*sin(u(2))];
objJ = @(zSeq,uSeq) norm(zSeq(:,end-2)-zRef)^2+norm(zSeq(:,end-1)-zRef)^2+norm(zSeq(:,end)-zRef)^2
cIE = @(zSeq,uSeq) [zSeq(1,:)'-20;zSeq(2,:)'-10;zSeq(3,:)'-10;zSeq(4,:)'-2*pi;...
       -zSeq(1,:)'-20;-zSeq(2,:)'-5;-zSeq(3,:)'-10;-zSeq(4,:)'-2*pi;...
       uSeq(1,:)'-1.5;-uSeq(1,:)'-1.5;uSeq(2,:)'-0.6;-uSeq(2,:)'-0.6;...
       uSeq(2,2:end)'-uSeq(2,1:end-1)'-0.2;-uSeq(2,2:end)'+uSeq(2,1:end-1)'-0.2;...
       uSeq(1,2:end)'-uSeq(1,1:end-1)'-0.06;-uSeq(1,2:end)'+uSeq(1,1:end-1)'-0.06];
cE = @(zSeq,uSeq) [zSeq(:,1) - [0;3;0;0];zSeq(:,end)-[0;0;0;-pi/2]];
parm.fh = fDyn;
parm.ts = TS;
parm.nu = nu;
parm.nx = nx;
parm.x0 = [0;3;0;0];
parm.Jh = objJ;
parm.cIEh = cIE;
parm.cEh = cE;
nDV = parm.nu*N;
dvInit = randn(nDV,1);
fmcOBJ = @(dv) fminconDynamicSystemTemplate(dv,parm,'obj');
fmcCON = @(dv) fminconDynamicSystemTemplate(dv,parm,'constraint');
options = optimoptions('fmincon','MaxFunctionEvaluations',20000,'display','iter');
[uDV, FVAL, EXITFLAG, OUTPUT, LAMBDA, GRAD] = fmincon(fmcOBJ,dvInit,...
[],[],[],[],[],[],fmcCON,options);
uSeq = reshape(uDV,[nu,N]);
zSeq = zeros(nx,N);
zSeq(:,1) = parm.x0;
for i = 1:N-1
    zSeq(:,i+1) = zSeq(:,i) + TS*fDyn(zSeq(:,i),uSeq(:,i));
end
clf
subplot(4,1,1)
plot(TS:TS:TS*N,zSeq(1,:),'g')
xlabel('Sample Time(sec)')
ylabel('x coordinate')
subplot(4,1,2)
plot(TS:TS:TS*N,zSeq(2,:),'r')
xlabel('Sample Time(sec)')
ylabel('y coordinate')
subplot(4,1,3)
plot(TS:TS:TS*N,zSeq(3,:),'b')
xlabel('Sample Time(sec)')
ylabel('Speed of vehicle')
subplot(4,1,4)
plot(TS:TS:TS*N,zSeq(4,:),'p')
xlabel('Sample Time(sec)')
ylabel('heading angle')


 
   