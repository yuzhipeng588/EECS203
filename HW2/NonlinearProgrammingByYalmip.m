%% Nonlinear programming: YALMIP formulation

%% Create decision variable
x = sdpvar(2,1);

%% Create objective function
f = log(1+x(1)^2)-x(2);

%% Create constraints
g = (1+x(1)^2)^2+x(2)^2-4;
Constr = g==0;

%% Make options on solver
options = sdpsettings('verbose',1,'solver','Ipopt');
%options = sdpsettings('verbose',1);

%% Solve the nonlinear programming
optimize(Constr,f,options)

%% Display the values of decision variables and cost 
double(x)
double(f)

%% Attribution
% ME C231A and EECS C220B, UC Berkeley, Fall 2016