function [TF] = isSystemStable(alpha)
%TF= ((((1+2*alpha)^2)/8-5/4)^2<1);
%TF=((1+2*alpha)^2)<2;
A = [1/3 0 0 0;0 -1/2 alpha 0;0 1/2 -5/4 0;-1/2 0 0 1/3];
%B = [0;-2;4;0];
%C = [1/2 0 1/3 0];
%D = [0];
%[~, p, ~] = ss2zp(A, B, C, D);
E=eig(A);
F = [abs(E(1))<1 abs(E(2))<1 abs(E(3))<1 abs(E(4))<1];
%F = [p(1)<0 p(2)<0 p(3)<0 p(4)<0];
TF = all(F);
end