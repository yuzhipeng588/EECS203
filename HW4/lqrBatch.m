function [K,P] = lqrBatch(A,B,Q,R,P,N)

nx = size(A,1);
nu = size(B,2);
Sx = zeros(nx*(N+1),nx);
Su = zeros(nx*(N+1),nu*N);
Sx(1:nx,:) = eye(nx);

for i=1:N
    Sx(nx*i+1:nx*(i+1),:) = A*Sx(nx*(i-1)+1:nx*i,:);
    Su(nx*i+1:nx*(i+1),1:i*nu) = [A*Su(nx*(i-1)+1:nx*i,1:(i-1)*nu) B];
end
Qbar  = blkdiag(kron(eye(N),Q),P);
Rbar = kron(eye(N),R);
H=Su'*Qbar*Su+Rbar;
F=Sx'*Qbar*Su;
K=-inv(H)*F';
P=-F*inv(H)*F'+Sx'*Qbar*Sx;