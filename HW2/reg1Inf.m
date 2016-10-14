function [xOpt, J] = reg1Inf(A1, b1, Ainf, binf, Ac, bc)


%Linear programming:
m=length(A1(:,1));
p=length(Ainf(:,1));
q=length(Ac(:,1));
n=length(A1(1,:));
f = [zeros(n,1);ones(m,1);1];
A = [A1,-1*eye(m,m),zeros(m,1);
    -1*A1,-1*eye(m,m),zeros(m,1);
    Ainf,zeros(p,m),-1*ones(p,1);
    -1*Ainf,zeros(p,m),-1*ones(p,1);
    Ac,zeros(q,m),zeros(q,1);
    zeros(m,n),-1*eye(m,m),zeros(m,1);
    zeros(1,n),zeros(1,m),-1;];
b = [b1;-1*b1;binf;-1*binf;bc;zeros(m,1);zeros(1,1)];
[xOptf, J] = linprog(f,A,b);
xOpt=xOptf(1:n);
if (J == -2)
    xOpt = 'empty';
    J = 'inf';
end
end