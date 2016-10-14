function [A, B, C, D, maBar, wBar, alphaBar] = hcLinearModel(vBar,c1, c2, c3, c4)
[maBar,wBar,alphaBar]=hcEqPt(vBar, c1, c2, c3, c4);
A=zeros(2,2);
A(1,1)=-c2*wBar;
A(2,1)=c3/36.4;
A(1,2)=-c2*maBar;
A(2,2)=-(0.106+2*c4*wBar)/36.4;
B=zeros(2,1);
if(alphaBar<0||alphaBar>1.4) 
    B(1,1)=0;
end
if(alphaBar>=0&&alphaBar<=1.4)
    B(1,1)=1.14*c1*sin(1.14*alphaBar-0.0252);
end

C=[0,0.129];
D=0;
end