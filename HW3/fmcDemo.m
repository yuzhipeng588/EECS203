%% Using FMINCON to solve dynamic optimization problems
% Two approaches are presented, both reformulating the problem to a general
% nonlinear program.  In one case, "substitution", the decision variable
% consists solely of the input sequence (as the resulting state sequence is
% an explicit function of the intial condition and the input sequence).  In
% the other case, both the input *and* state sequences are decision
% variables, and the optimization problem includes equality constraints
% which constrain the state and input sequences to satisfy the system's
% governing equation.

%% Some parameters
TS = 0.05;
N = 120;
TFinal = TS*N;

%% Continuous dynamics
%
% $${\dot x}_1 = \sin(x_1) + \frac{\gamma}{1+x_1^2} \tan^{-1} (x_2)$$
%
% $${\dot x}_2 = -\frac{1}{\tau} ( x_2 - u )$$
%
tau = 0.2;
gamma = 10;
fDyn = @(x,u) [-sin(x(1))+gamma/(1+x(1)^2)*atan(x(2)); -1/tau*(-u+x(2))];
nx = 2;
nu = 1;

%% Desired State trajectory
% Create specific piecewise-linear desired trajectory for x1.
tValues = [0 3 3.5 5.5 6];
xDesValues = [0 0.75*pi/4 0.67*pi/4 1.25*pi/4 1.25*pi/4];
tGrid = 0:TS:TFinal;
xDesGrid = interp1(tValues, xDesValues, tGrid);
plot(TS*(0:N), xDesGrid)
title('Desired Trajectory for x1')
xlabel('Time')

%% Create anonymous function representing objective function
% Write a function which has two input arguments: a state sequence and an
% input sequence, and returns the value of the objective.
objJ = @(xSeq, uSeq) TS*norm(xSeq(1,:)-xDesGrid)^2;

%% Constraint Functions
% The inequality constraint function accepts two arguments - a state and
% input sequence, and returns a vector of values.  |fmincon| interprets this
% as values that are constrained to all be <= 0.  In our example, we have
% constraints on the final value of |x1| (should be close to final value of
% |xDesGrid|), as well as constraints on the magnitude of ${\dot x}_2$.
% Here we put the rate-bound on $x_2$ as 0.07.
RBValue = 0.07;
cIE = @(xSeq, uSeq) [0.975*xDesGrid(end)-xSeq(1,end);...
     xSeq(1,end)-1.025*xDesGrid(end);...
    (-1/tau*(-uSeq+xSeq(2,1:end-1))')-RBValue;...
    -(-1/tau*(-uSeq+xSeq(2,1:end-1))')-RBValue];
%%
% This control problem has no explicit equality constraints.
cE = @(xSeq, uSeq) [];

%% Create |parm| object, which has details of the problem
% Look in |fminconDynamicSystemTemplate| to see what variables should be
% specified as fields of |parm|.  They are listed below with short comments
% to remind you of their meanings.
parm.fh = fDyn;        % handle to continuous-time dynamics
parm.ts = TS;          % discretization time
parm.nu = nu;          % number of control inputs
parm.nx = nx;          % number of states
parm.x0 = zeros(nx,1); % initial condition for state
parm.Jh = objJ;        % handle to objective function (acts on state and input sequence)
parm.cIEh = cIE;       % handle to inequality constraint function
parm.cEh = cE;         % handle to equality constraint function (do not include state equations)

%% Case 1: only the input is treated as a decision variable
% By setting the messages to |fminconDynamicSystemTemplate| to |'obj'| and
% |'constraint'|, it is assumed that the only decision variables are the
% input sequence, and the state sequence will automatically be solved for,
% given the initial condition, dynamic equations, and input sequence.  Let
% |nDV| denote the number of decision variables.  Since the input dimension
% is known (|parm.nu|) and the horizon (|N|) is known, the number of
% decision variables is easy to deermine.
nDV = parm.nu*N; 
dvInit = randn(nDV,1);  % give FMINCON a random initial value for decision variable
fmcOBJ = @(dv) fminconDynamicSystemTemplate(dv, parm, 'obj');
fmcCON = @(dv) fminconDynamicSystemTemplate(dv, parm, 'constraint');

%% Call FMINCON
options = optimoptions('fmincon','MaxFunctionEvaluations',20000,'display','iter'); 
[uDV,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD] = fmincon(fmcOBJ,dvInit,...
    [],[],[],[],[],[],fmcCON,options);
% The returned variable |uDV| should be a column vector, of dimension
% |nDV|.  It represents the optimal input trajectory, as determined by the
% optimization.

%% Recover input/state trajectories and plot
% Reshape the decision variable into a sequencte of input values. 
uSeq = reshape(uDV,[nu,N]);
% Simulate the discretized system, starting from the specified initial
% condition, using the optimal input.
xSeq = zeros(nx,N+1);
xSeq(:,1) = parm.x0;
for i=1:N
    xSeq(:,i+1) = xSeq(:,i) + TS*fDyn(xSeq(:,i), uSeq(:,i));
end
% Reconstruct the signal ($\dot x}_2$) that should be bounded by |RBvalue|
x2Dot = -1/tau*(-uSeq+xSeq(2,1:end-1));
clf
subplot(2,1,1)
plot(1:N,uSeq,'g',1:N,x2Dot(1:N),'k--',1:N,...
   repmat(RBValue,[1 N]),'r',1:N,repmat(-RBValue,[1 N]),'r')
legend('Input','Rate-of-Change','RateBound')
title('Optimal input, rate-of-change and Bound')
grid on
subplot(2,1,2)
plot(1:N+1, xDesGrid, 'r', 1:N+1,xSeq(1,:),'b')
legend('x1Desired', 'x1 (actual)')
title('x1: Desired and Actual')

%% Effect of uncertainties on system response
% Create new dynamics, with slightly different parameters.  Use the
% optimized control signal (optimized on original plant model) on this
% perturbed plant model.  See the degradation in the tracking performance.
tauPerturbed = 0.22;
gammaPerturbed = 10.5;
fDynPerturbed = @(x,u) [-sin(x(1))+gammaPerturbed/(1+x(1)^2)*atan(x(2)); ...
   -1/tauPerturbed*(-u+x(2))];
xSeq = zeros(2,N+1);
uSeq = reshape(uDV,[parm.nu,N]);
xSeq(:,1) = parm.x0;
for i=1:N
    xSeq(:,i+1) = xSeq(:,i) + TS*fDynPerturbed(xSeq(:,i), uSeq(:,i));
end
clf
plot(1:N+1, xDesGrid, 'r', 1:N+1,xSeq(1,:),'b')
legend('x1Desired', 'x1 (actual)', 'location','best')
title('x1: Desired and Actual (Plant/Model mismatch)')
%%
% *This degradation points to the advantage of feedback* - instead of computing
% 120 control actions (here), and just applying them, it is advantageous to
% apply some portion of the optimal input sequence, measure the actual
% response, and then reoptimize the input over some time-interval of the
% future (perhaps another 120 steps).  Even if there is a mismatch between
% the true plant behavior and the plant model (used in optimization), the
% continuous act of reassessing (based on measurement) and reoptimization
% provides feedback which leads to corrective actions.  We will revisit
% this extensively in the MPC/receding horizon control section.

%% Solve problem with equality constraints to represent dynamics
% There are still no additional equality constraints.  However, by setting
% the messages to |fminconDynamicSystemTemplate| to have the suffix
% |StateEq|, the optimization problem is formulated with decision variables
% for both input *and* state, and the state-equations are imposed as
% equality constraints (see the variable |StateEvolveMismatch| in the code
% for |fminconDynamicSystemTemplate|).
nDV = (parm.nu + parm.nx)*N;
dvInit = randn(nDV,1);
fmcOBJ = @(dv) fminconDynamicSystemTemplate(dv, parm, 'objStateEQ');
fmcCON = @(dv) fminconDynamicSystemTemplate(dv, parm, 'constraintStateEQ');

%% Call FMINCON
options = optimoptions('fmincon','MaxFunctionEvaluations',80000,'display','iter'); 
[uxDV,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD] = fmincon(fmcOBJ,randn(nDV,1),...
    [],[],[],[],[],[],fmcCON,options);
%%
% Check size of decision variable, and verify that this makes sense to you
numel(uxDV)

%% Recover input/state trajectories and plot
uSeq = reshape(uxDV(1:N*parm.nu),[parm.nu,N]);
xSeq = [parm.x0 reshape(uxDV(N*parm.nu+1:end),[parm.nx,N])];
x2Dot = -1/tau*(-uSeq+xSeq(2,1:end-1));
clf
subplot(2,1,1)
plot(1:N,uSeq,'g',1:N,x2Dot(1:N),'k--',1:N,...
   repmat(RBValue,[1 N]),'r',1:N,repmat(-RBValue,[1 N]),'r')
legend('Input','Rate-of-Change','RateBound')
title('Optimal input, rate-of-change and Bound')
grid on
subplot(2,1,2)
plot(1:N+1, xDesGrid, 'r', 1:N+1,xSeq(1,:),'b')
legend('x1Desired', 'x1 (actual)')
title('x1: Desired and Actual')

%% Attribution
% ME C231A and EECS C220B, UC Berkeley, Fall 2016