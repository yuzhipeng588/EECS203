
cp = 1;
mz = 100;
cz = 20;
u1H = @(t) 1000*(2 + sin(0.1*t));
u2H = @(t) 25 + sin(0.2*t);
qH = @(t) 1000*(t>50);
Tinit=25;
tSpan=[0 200];
%bldgHTMModel=@(t,T) (qH(t)+cp*u1H(t).*(u2H(t)-T))/(mz+cz);
[tSol,TSol]= ode45(@(t,T) bldgHTM(T, u1H(t), u2H(t), qH(t), mz, cz, cp),tSpan,Tinit);
TS=0.1;
[tESol,TESol]=recall_xEsol(200/0.1,0.1);
figure;
hold on;
plot(tSol,TSol,tESol,TESol);

%plot(tSol,d_vSol,'b-o','LineWidth',2);
%axis([-Inf Inf -1 1]);
xlabel('t');
ylabel('T');
title('Plot of T');
legend('"Exact"','Euler');
box on;
legend('boxoff');
hold off;