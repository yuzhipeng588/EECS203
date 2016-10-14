function [tSol, maSol, vSol] = sinusoidThrottleSim(vBar, Beta, w,c1, c2, c3, c4, TFinal)
% Compute maBar, wBar and alphaBar from vBar
[maBar,wBar,alphaBar]=hcEqPt(vBar, c1, c2, c3, c4);
% Define uHan = @(t) alphaBar + Beta*sin(w*t)
uHan = @(t) alphaBar + Beta*sin(w*t);
% Define 2-by-1 initial condition vector, xInit
xInit=[maBar;wBar];
% Define timespan of simulation, tSpan, from 0 to TFinal
tSpan=[0 TFinal];
%Create function handle, suitable for ODE45, using uHan
odeSimModel = @(t, x) hcModel(x, uHan(t), c1, c2 ,c3, c4);
% Call ODE45
[tSol, xSol] = ode45(odeSimModel, tSpan,xInit);
% Extract maSol from xSol
maSol=xSol(:,1);
% Define vSol from xSol
vSol=xSol(:,2)*0.129;
end