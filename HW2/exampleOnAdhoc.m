%% QUADPROG demo: Optimal versus saturated constrained least squares

%% Create example data
n = 6;
A = rand(10,n)/15;
b = rand(10,1);
H = 2*A'*A;
f = -2*A'*b;
ub = 0.5;
lb = -0.4;

%% Solve problem as formulated
x_cls = quadprog(H, f, [eye(n);-eye(n)], [ub*ones(n,1);-lb*ones(n,1)]);

%% Solve standard least squares, and project to feasible set
x_ls = A\b; % get standard least-squares solution
x_sat = x_ls;
x_sat(x_sat>ub) = ub; % set any entries that are greater than 0.5 to 0.5
x_sat(x_sat<lb) = lb; % set any entries that are less than -0.5 to -0.5

%% Compare performance (ie., cost function) to direct solution from QUADPROG
[norm(A*x_cls-b)  norm(A*x_sat-b)]
[x_cls x_sat x_ls]

%% Attribution
% ME C231A and EECS C220B, UC Berkeley, Fall 2016