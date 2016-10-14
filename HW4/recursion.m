function [J,U,Jglobalo,Uglobalo]=recursion(i,N,P,Jglobal,Uglobal)
global Jglobalo Uglobalo;
Jglobalo=Jglobal;
Uglobalo=Uglobal;
A=[1,1;0,1];
B=[0;1];
Q=eye(2);
R=0.1;
nx = size(A,1);
nu = size(B,2);

%u=sdpvar(1,1);
for j=-15:1:15
    for k=-15:1:15
        x=[j;k];
        %C=[abs(u)<=1];
        u0=0;
        fun=@ (u) x'*(A'*P(:,:,i+1)*A+Q)*x+u'*(B'*P(:,:,i+1)*B+R)*u+2*x'*A'*P(:,:,i+1)*B*u;
        AA = [];
        b = [];
        Aeq = [];
        beq = [];
        lb=-1;
        ub=1;
        [u,fval]=fmincon(fun,u0,AA,b,Aeq,beq,lb,ub);
        P(:,:,i) = Q + A'*P(:,:,i+1)*A - A'*P(:,:,i+1)*B*inv(R+B'*P(:,:,i+1)*B)*B'*P(:,:,i+1)*A;
        %Options = sdpsettings('solver','fmincon');
        %optimize(C,obj,Options);
        J=double(fval);
        U=double(u);
        if(i>1)
             [J,Ua,~,~]=recursion(i-1,N,P,Jglobalo,Uglobalo);
             U=[Ua,U];
        end
        if(i==1)
            x0=[-1;-1];
            J=x0'*P(:,:,1)*x0;
            if(J<Jglobalo)
                Jglobalo=J;
            end
        end
        if(i==N)
            if(J==Jglobalo)
                Uglobalo=U;
            end
        end
    end
end

end