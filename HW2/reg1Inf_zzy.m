function [xOpt, J] = reg1Inf_zzy(A1, b1, Ainf, binf, Ac, bc)
[m n] = size(A1);
[q n] = size(Ac);
[p n] = size(Ainf);
f = [zeros(1,n) ones(1,n) 1]';
A = zeros(q+2*m+2*p,2*n+1);
A(1:q,1:n) = Ac;
A(1:q,n+1:2*n+1) = zeros(q,n+1);

A(q+1:q+m,1:n) = A1;
A(q+1:q+m,n+1:2*n+1) = [-ones(m,n) zeros(m,1)];

A(q+1+m:q+2*m,1:n) = -A1;
A(q+1+m:q+2*m,n+1:2*n+1) = [-ones(m,n) zeros(m,1)];

A(q+2*m+1:q+2*m+p,1:n) = Ainf;
A(q+2*m+1:q+2*m+p,n+1:2*n+1) = [zeros(p,n) -ones(p,1)];

A(q+2*m+p+1:q+2*m+2*p,1:n)  = -Ainf;
A(q+2*m+p+1:q+2*m+2*p,n+1:2*n+1) = [zeros(p,n) -ones(p,1)];

b = zeros(q+2*m+2*p,1);

b(1:q) = bc;
b(q+1:q+m) = b1;
b(q+m+1:q+2*m) = -b1;
b(q+2*m+1:q+2*m+p) = binf;
b(q+2*m+p+1:q+2*m+2*p) = -binf;

[x, J] = linprog(f,A,b);
xOpt = x(1:n);


