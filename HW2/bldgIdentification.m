function estParm = bldgIdentification(Tdata, u1Seq, u2Seq)
%Tdata=interp1(Tdata(:,1), Tdata(:,2));
%u1Seq=interp1(u1Seq(:,1), u1Seq(:,2));
%u2Seq=interp1(u2Seq(:,1), u2Seq(:,2));
p = sdpvar(2,1);
%e=sdpvar(1,length(Tdata));
e=sdpvar(1,length(Tdata)-1);
p1d=p(1)>=-inf;
p2d=p(2)>=-inf;
C=[p1d,p2d];
for k=1:length(Tdata)-1
    g= Tdata(k+1,1)-((1-p(1)*u1Seq(k,1))*Tdata(k,1) + p(2)*u1Seq(k,1)*u2Seq(k,1));
    C =[C, e(k)==g];
    %e(k)=Tdata(k+1)-(1-p(1)*u1Seq(k))*Tdata(k) + p(2)*u1Seq(k)*u2Seq(k);
end
obj= norm(e)^2;
options = sdpsettings('verbose', true, 'solver', 'quadprog');
optimize(C,obj,options);
estParm=double(p);
end