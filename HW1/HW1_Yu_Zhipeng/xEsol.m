function xEsol_f= xEsol(t,x,u)
cp = 1;
mz = 100;
cz = 20;
TS=0.1;
%xEsol_f= xEsol(t-TS) + TS*bldgHTM(xEsol(t-TS), u1H(t-TS), u2H(t-TS), qH(t-TS), mz, cz, cp);
xEsol_f=bldgHTM(x(t), u(1), u(2), qH(t), mz, cz, cp);
end