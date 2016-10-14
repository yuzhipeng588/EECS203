A=eye(5);
b=ones(5,1);
H = 2*A'*A;
f = -2*A'*b;
x_cls = quadprog(H, f, [eye(5);-eye(5)], [0.5*ones(5,1);0.5*ones(5,1)]);
x_ls = A\b; % get standard least-squares solution
x_ls(x_ls>0.5) = 0.5; % set any entries that are greater than 0.5 to 0.5
x_ls(x_ls<-0.5) = -0.5; % set any entries that are less than -0.5 to -0.5
% Compare performance (ie., cost function) to direct solution from QUADPROG
disp(norm(A*x_cls-b));
disp(norm(A*x_ls-b));