c1=0.6;
c2=0.095;
c3=47500;
c4=0.0026;
u=0:1.4;
ma=1;we=2;
x(1)=ma;
x(2)=we;
%syms vBar positive;
for vBar=59:0.0001:80
[maBar, wBar, alphaBar] = hcEqPt(vBar, c1, c2, c3, c4);
if((alphaBar-1.4)*(alphaBar-1.4)<0.000000001)
    break;
end
end








