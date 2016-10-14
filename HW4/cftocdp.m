x0=[-1;-1];
N=3;
A=[1,1;0,1];
B=[0;1];
Q=eye(2);
R=0.1;
nx = size(A,1);
nu = size(B,2);
%P = zeros(nx,nx,N+1);
%PN=eye(2);
%P(:,:,N+1) = PN;
P=eye(2);
Jglobal=inf;
Uglobal=[];
x1space = linspace(-15,15,100);
x2space = linspace(-15,15,100);
Js = @(x,u) x'*Q*x+u'*R*u;
Jt = @(x) x'*P*x;
u0=0;
lb = -1;
ub = 1;
AA = [];
b = [];
Aeq = [];
beq = [];
U = zeros(size(x1space,2),size(x2space,2),N);
J = zeros(size(x1space,2),size(x2space,2),N);
%[J,U,Jglobal,Uglobal]=recursion(N,N,P,Jglobal,Uglobal);
%{
function [J,U,Jglobalo,Uglobalo]=recursion(i,N,P,Jglobal,Uglobal)
global Jglobalo Uglobalo;
Jglobalo=Jglobal;
Uglobalo=Uglobal;
A=[1,1;0,1];
B=[0;1];
Q=eye(2);
R=0.1;
nx = size(A,1);
nu = size(B,2);

%u=sdpvar(1,1);
for j=-15:1:15
    for k=-15:1:15
        x=[j;k];
        %C=[abs(u)<=1];
        u0=0;
        fun=@ (u) x'*(A'*P(:,:,i+1)*A+Q)*x+u'*(B'*P(:,:,i+1)*B+R)*u+2*x'*A'*P(:,:,i+1)*B*u;
        AA = [];
        b = [];
        Aeq = [];
        beq = [];
        lb=-1;
        ub=1;
        [u,fval]=fmincon(fun,u0,AA,b,Aeq,beq,lb,ub);
        P(:,:,i) = Q + A'*P(:,:,i+1)*A - A'*P(:,:,i+1)*B*inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;
        %Options = sdpsettings('solver','fmincon');
        %optimize(C,obj,Options);
        J=double(fval);
        U=double(u);
        if(i>1)
             [J,Ua,~,~]=recursion(i-1,N,P,Jglobalo,Uglobalo);
             U=[Ua,U];
        end
        if(i==1)
            x0=[-1;-1];
            J=x0'*P(:,:,1)*x0;
            if(J<Jglobalo)
                Jglobalo=J;
            end
        end
        if(i==N)
            if(J==Jglobalo)
                Uglobalo=U;
            end
        end
    end
end

end
%}
for i = N:-1:1
    for j = 1:size(x1space,2)
        for k = 1:size(x2space,2)
            x = [x1space(j);x2space(k)];
            [U(j,k,i),J(j,k,i)] = fmincon(@(u)Js(x,u)+Jt(A*x+B*u),u0,AA,b,Aeq,beq,lb,ub);
        end
    end
    Jt = @ (x) interp2(x1space,x2space,J(:,:,i)',x(1),x(2),'spline');
end
U0opt = zeros(size(B,2),N);
xopt=zeros(size(A,1),N+1);
xopt(:,1)=x0;
for i = 1:N
    U0opt(:,i) = interp2(x1space,x2space,U(:,:,i)',xopt(1,i),xopt(2,i),'spline');
    xopt(:,i+1)=A*xopt(:,i)+B*U0opt(:,i);
end
double(U0opt)
%u=sdpvar(1,1);
