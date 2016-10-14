%% 2(a)
tic
x0=[-1;-1];
N=3;
A=[1,1;0,1];
B=[0;1];
Q=eye(2);
R=0.1;
P=eye(2);
nx = size(A,1);
nu = size(B,2);
Sx = zeros(nx*(N+1),nx);
Su = zeros(nx*(N+1),nu*N);
Sx(1:nx,:) = eye(nx);

u=sdpvar(N,1);
x=sdpvar(2,N+1);
C=[x(:,1)==x0,abs(u)<=1];
for i=1:N
    Sx(nx*i+1:nx*(i+1),:) = A*Sx(nx*(i-1)+1:nx*i,:);
    Su(nx*i+1:nx*(i+1),1:i*nu) = [A*Su(nx*(i-1)+1:nx*i,1:(i-1)*nu) B];
    C=[C,abs(x(:,i+1))<=15];
end
Qbar  = blkdiag(kron(eye(N),Q),P);
Rbar = kron(eye(N),R);
H=Su'*Qbar*Su+Rbar;
F=Sx'*Qbar*Su;


obj=u'*H*u+2*x(:,1)'*F*u+x(:,1)'*Sx'*Qbar*Sx*x(:,1);
Options = sdpsettings('solver','quadprog');
out=optimize(C,obj,Options);
double(u)
double(obj)
toc
%% 2(b)
tic
x0=[-1;-1];
N=3;
A=[1,1;0,1];
B=[0;1];
Q=eye(2);
R=0.1;
P=eye(2);
nx = size(A,1);
nu = size(B,2);
Sx = zeros(nx*(N+1),nx);
Su = zeros(nx*(N+1),nu*N);
Sx(1:nx,:) = eye(nx);

u=sdpvar(N,1);
x=sdpvar(2,N+1);
C=[x(:,1)==x0,abs(u)<=1];
for i=1:N
    Sx(nx*i+1:nx*(i+1),:) = A*Sx(nx*(i-1)+1:nx*i,:);
    Su(nx*i+1:nx*(i+1),1:i*nu) = [A*Su(nx*(i-1)+1:nx*i,1:(i-1)*nu) B];
    C=[C,x(:,i+1)==A*x(:,i)+B*u(i),abs(x(:,i+1))<=15];
end
Qbar  = blkdiag(kron(eye(N),Q),P);
Rbar = kron(eye(N),R);
H=Su'*Qbar*Su+Rbar;
F=Sx'*Qbar*Su;


obj=u'*H*u+2*x(:,1)'*F*u+x(:,1)'*Sx'*Qbar*Sx*x(:,1);
Options = sdpsettings('solver','quadprog');
out=optimize(C,obj,Options);
double(u)
double(obj)
toc