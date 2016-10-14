%% 1(a)
x0=[1;-1];
N=50;
A=[0.77,-0.35;0.49,0.91];
B=[0.04;0.15];
Q=[500,0;0,100];
R=1;
P=[1500,0;0,100];
[K,P] = lqrBatch(A,B,Q,R,P,N);
U0opt=K*x0
J0opt=x0'*P*x0

%% 1(b)
x0=[1;-1];
N=50;
A=[0.77,-0.35;0.49,0.91];
B=[0.04;0.15];
Q=[500,0;0,100];
R=1;
P=[1500,0;0,100];
nx = size(A,1);
nu = size(B,2);
Sx = zeros(nx*(N+1),nx);
Su = zeros(nx*(N+1),nu*N);
Sx(1:nx,:) = eye(nx);

for i=1:N
    Sx(nx*i+1:nx*(i+1),:) = A*Sx(nx*(i-1)+1:nx*i,:);
    Su(nx*i+1:nx*(i+1),1:i*nu) = [A*Su(nx*(i-1)+1:nx*i,1:(i-1)*nu) B];
end
Qbar  = blkdiag(kron(eye(N),Q),P);
Rbar = kron(eye(N),R);
H=Su'*Qbar*Su+Rbar;
F=Sx'*Qbar*Su;
u=sdpvar(N,1);
x=sdpvar(2,1);
C=x==x0;
obj=u'*H*u+2*x'*F*u+x'*Sx'*Qbar*Sx*x;
Options = sdpsettings('solver','quadprog');
out=optimize(C,obj,Options);
double(u)
double(obj)

%% 1(c)
x0=[1;-1];
N=50;
A=[0.77,-0.35;0.49,0.91];
B=[0.04;0.15];
Q=[500,0;0,100];
R=1;
nx = size(A,1);
nu = size(B,2);
P = zeros(nx,nx,N+1);
PN=[1500,0;0,100];
P(:,:,N+1) = PN;
F=zeros(1,2,N);
for i=N:-1:1
    F(:,:,i)= -inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;

    P(:,:,i) = Q + A'*P(:,:,i+1)*A - A'*P(:,:,i+1)*B*inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;

end
Jopt=x0'*P(:,:,1)*x0;

%% 1(d)
%%Batch
D=[0.1;0.1];
N=50;
w=(10^0.5)*randn(1,51);
w(1)=0;
D=[0;0];
for i=1:N
    D=[D;0.1*w(i+1);0.1*w(i+1)];
end


x0=[1;-1];

A=[0.77,-0.35;0.49,0.91];
B=[0.04;0.15];
Q=[500,0;0,100];
R=1;
P=[1500,0;0,100];
nx = size(A,1);
nu = size(B,2);
Sx = zeros(nx*(N+1),nx);
Su = zeros(nx*(N+1),nu*N);
Sx(1:nx,:) = eye(nx);

for i=1:N
    Sx(nx*i+1:nx*(i+1),:) = A*Sx(nx*(i-1)+1:nx*i,:);
    Su(nx*i+1:nx*(i+1),1:i*nu) = [A*Su(nx*(i-1)+1:nx*i,1:(i-1)*nu) B];
end
Qbar  = blkdiag(kron(eye(N),Q),P);
Rbar = kron(eye(N),R);
H=Su'*Qbar*Su+Rbar;
F=Sx'*Qbar*Su;
u=sdpvar(N,1);
x=sdpvar(2,1);
C=x==x0;
obj=u'*H*u+2*(x'*F+D'*Qbar*Su)*u+x'*Sx'*Qbar*Sx*x;
Options = sdpsettings('solver','quadprog');
out=optimize(C,obj,Options);
double(u)

%%recursive
x0=[1;-1];
N=50;
A=[0.77,-0.35;0.49,0.91];
B=[0.04;0.15];
Q=[500,0;0,100];
R=1;
P = zeros(nx,nx,N+1);
PN=[1500,0;0,100];
P(:,:,N+1) = PN;
F=zeros(1,2,N);
for i=N:-1:1
    F(:,:,i)= -inv(R+B'*P(:,:,i+1)*B)*(B'*P(:,:,i+1)*A);
    
    P(:,:,i) = Q + A'*P(:,:,i+1)*A - A'*P(:,:,i+1)*B*inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;

end
U=[F(:,:,1)*x0];
for i=2:N
    x=A*x0+B*U(i-1)+D(2*i-1:2*i);
    U=[U;F(:,:,1)*x+D(2*i+1:2*i+2)'*P(:,:,i+1)*B];
end
double(U)


























