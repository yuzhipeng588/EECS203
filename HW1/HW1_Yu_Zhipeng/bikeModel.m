function [a1,a2,a3,a4] = bikeModel(t, X, U, Message, lr, lf)
% Level-1 Sfunction for kinematic bicycle model.  Used in ME C231A and EECS
% C220B, UC Berkeley, Fall 2016.   Extra parameters are physical dimensions
% associated with the bike model.
switch Message
   case 0
      % Initialization phase.  Follow this format (see slides too)
      tmp = simsizes;
      tmp.NumContStates = 4;
      tmp.NumDiscStates = 0;
      tmp.NumOutputs = 4;
      tmp.NumInputs = 2;
      tmp.DirFeedthrough = 0;   % does y depend explicitly on u?
      tmp.NumSampleTimes = 1;
      a1 = simsizes(tmp);
      a2 = [0;0;0;0];  % X(0), initial condition, 4-by-1 column
      a3 = [];  % always,
      a4 = [0 0]; % Sample time, offset
   case 1
      % Compute state derivatives, given (t,X,U)
      % Pull apart state, using model-dependent convention
      x = X(1);   % unused, as x does not affect any state derivatives
      y = X(2);   % unused, as y does not affect any state derivatives
      v = X(3);
      psi = X(4);
      % Pull apart input, using model-dependent convention
      a = U(1);
      deltaF = U(2);
      % Compute beta
      beta = atan(lr/(lr+lf)*tan(deltaF));
      % Compute state derivatives
      xdot = v*cos(psi+beta);
      ydot = v*sin(psi+beta);
      vdot = a;
      psidot = v/lr*sin(beta);
      % Pack up state derivatives into column vector
      a1 = [xdot; ydot; vdot; psidot];
   case 3
      % Compute output, given (t,X,U)
      % In this model, all states are outputs.  Simply copy X to output
      % argument
      a1 = X;
end

%% Attribution
% ME C231A and EECS C220B, UC Berkeley, Fall 2016



