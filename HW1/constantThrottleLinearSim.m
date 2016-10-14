function [tSol, d_maSol, d_vSol] = constantThrottleLinearSim(vBar, Beta, c1, c2, c3, c4, TFinal)
% Compute linearization from vBar
[A, B, ~, ~, ~, ~, ~] = hcLinearModel(vBar,c1, c2, c3, c4);
% Define d_uVal = Beta
d_uVal = Beta;
% Define 2-by-1 initial condition vector, d_xInit
d_xInit=[0,0];
% Define timespan of simulation, tSpan, from 0 to TFinal
tSpan=[0 TFinal];
d_x=zeros(2,2);
% Create function handle, suitabl
%f=@(t,d_x) A*d_x(2,1)+B*d_uVal;
%f=@(t,x) [A(1,1)*x(1)+A(2,1)*x(2);A(1,2)*x(1)+A(2,2)*x(2)]+B*d_uVal;
f=@(t,x) A*x+B*d_uVal;
%odeSimModel2 = @(t, x)hcLinearModel(vBar);
% Call ODE45
[tSol, d_xSol] = ode45(f, tSpan,d_xInit );
% Extract d_maSol from state response
d_maSol=d_xSol(:,1);
% Define d_vSol from state response
d_vSol=0.129*d_xSol(:,2);
end