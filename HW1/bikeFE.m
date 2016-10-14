function [xp, yp, vp, psip] = bikeFE(x, y, v, psi, a, deltaF, TS)
lf = 1.738;
lr = 1.738;
Beta = atan(lr*tan(deltaF)/(lr+lf));
vp=a*TS+v;
psip=TS*(v*sin(Beta))/1.738+psi;
xp=x+TS*v*cos(psi+Beta);
yp=y+TS*v*sin(psi+Beta);

end