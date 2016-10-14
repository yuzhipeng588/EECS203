function xDot = hcModel(x, u, c1, c2 ,c3, c4)
xDot=zeros(2,1);
xDot(1)=c1*HW1_T(u)-c2*x(2)*x(1);
xDot(2)=(1/36.4)*(c3*x(1)-(0.106*x(2)+15.1)-21.5-c4*x(2)*x(2));
end