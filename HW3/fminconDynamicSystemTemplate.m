function [arg1, arg2] = fminconDynamicSystemTemplate(dv, parm, message)
% For fmincon, define
%    parm.ts, sample time for first-order euler integration
%    parm.nx, number of states
%    parm.nu, number of inputs
%    parm.fh = @(x,u) fdyn(x, u)
%    parm.Jh = @(xSeq,uSeq) J(xSeq, uSeq)
%    parm.cIEh = @(xSeq,uSeq) cIEh(xSeq, uSeq)
%    parm.cEh = @(xSeq,uSeq) cEh(xSeq, uSeq)
%    obj = @(dv) fminconDynamicSystemDemo(dv, parm, 'obj');
%    con = @(dv) fminconDynamicSystemDemo(dv, parm, 'constraint');

% During each iteration, FMINCON separately calls the objective and
% constraint function at the same value of the decision variable, DV.
% In many applications, there is a common calculation carried out in both
% the objective and constraint computation.  For effciency purposes, it is
% best to not repeat this.  This can be accomplished by placing the code
% for objective and constraint into the same function, and using a
% PERSISTENT variable to save the work from this common calculation so that
% it is available for the other function.
persistent CommonCalc;

switch message
    case {'obj', 'constraint'}
        % The first time a function 
        if isempty(CommonCalc) || ~isequal(dv, CommonCalc.dv)
            N = numel(dv)/parm.nu;  % dv is always control sequence on [0:(N-1)]
            uSeq = reshape(dv, [parm.nu, N]);  % input-sequence nu-by-N
            xSeq = zeros(parm.nx,N+1); % state-sequence nx-by-(N+1)
            xSeq(:,1) = parm.x0;       % initial condition is given
            for i=1:N
                xSeq(:,i+1) = xSeq(:,i) + parm.ts*parm.fh(xSeq(:,i), uSeq(:,i));
            end
            CommonCalc.Data.StateTraj = xSeq;
            CommonCalc.Data.InputTraj = uSeq;
            CommonCalc.dv = dv;
        end
        switch message
            case 'obj'
                % Compute object value, objVal, based on CommonCalc.Data
                % Return one scalar argument (objective function call)
                arg1 = parm.Jh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj);
            case 'constraint'
                % Compute inequality and equality constraint function values, CIEh,
                % CEh, based on CommonCalc.Data.
                arg1 = parm.cIEh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj);
                arg2 = parm.cEh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj);
            otherwise
                error(['Message "' message '" is unrecognized.']);
        end
    case {'objStateEQ', 'constraintStateEQ'}
        if isempty(CommonCalc) || ~isequal(dv, CommonCalc.dv)
            % dv is (after unwrapping) [uSeq(0:N-1) xSeq(1:N)]
            N = numel(dv)/(parm.nu+parm.nx);  
            uSeq = reshape(dv(1:parm.nu*N), [parm.nu, N]);  % input-sequence nu-by-N
            xSeq = [parm.x0 reshape(dv(parm.nu*N+1:end), [parm.nx, N])];
            StateEvolveMismatch = zeros(parm.nx, N);
            for i=1:N
                StateEvolveMismatch(:,i) = -xSeq(:,i+1) + xSeq(:,i) + parm.ts*parm.fh(xSeq(:,i), uSeq(:,i));
            end
            CommonCalc.Data.StateEvolveMismatch = StateEvolveMismatch;
            CommonCalc.Data.StateTraj = xSeq;
            CommonCalc.Data.InputTraj = uSeq;
            CommonCalc.dv = dv;
        end
        switch message
            case 'objStateEQ'
                % Compute object value, objVal, based on CommonCalc.Data
                % and supplied objective function handle, Jh
                arg1 = parm.Jh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj);
            case 'constraintStateEQ'
                % Compute inequality and equality constraint function values, CIEh,
                % CEh, based on CommonCalc.Data.  Include StateEvolveMismatch
                % as part of the equality constraints.
                arg1 = parm.cIEh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj);
                arg2 = [CommonCalc.Data.StateEvolveMismatch(:); ...
                    parm.cEh(CommonCalc.Data.StateTraj, CommonCalc.Data.InputTraj)];
            otherwise
                error(['Message "' message '" is unrecognized.']);
        end
end

%% Attribution
% ME C231A and EECS C220B, UC Berkeley, Fall 2016        