%% LQR backwards cost-to-go interation

%% Set up data
% General Random
nx = 3;
nu = 1;
A = randn(nx,nx);
B = randn(nx,nu);
Qsr = randn(nx,nx-1); Q = Qsr*Qsr';
Rsr = randn(nu,nu); R = Rsr*Rsr';
PNsr = randn(nx,nx-1); PN = PNsr*PNsr';

%% Finite-Time Iteration via D.P.
N = 5;
P = zeros(nx,nx,N+1);
P(:,:,N+1) = PN;
clc
for i=N:-1:1
    F(:,:,i)= -inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;
    %disp(['Iteration: ' int2str(i)]);
    %disp('Paused...');
    %pause
    P(:,:,i) = Q + A'*P(:,:,i+1)*A - A'*P(:,:,i+1)*B*inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;
    %disp(P(:,:,i))    
end


%% Comparison with batch approach
[K,Pbatch]=lqrBatch(A,B,Q,R,PN,N-1);
