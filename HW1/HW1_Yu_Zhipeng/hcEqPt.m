function [maBar, wBar,alphaBar] = hcEqPt(vBar, c1, c2, c3, c4)
wBar=vBar/0.129;
maBar=((0.106*wBar+15.1)+21.5+c4*wBar*wBar)/c3;
T=(c2*wBar*maBar/c1);
%if(T>=0.032&&T<=1)   
    alphaBar=(acos(1-T)+0.0252)/1.14;    
%end

end