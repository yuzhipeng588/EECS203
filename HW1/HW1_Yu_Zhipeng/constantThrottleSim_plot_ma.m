function constantThrottleSim_plot
c1=0.6;
c2=0.095;
c3=47500;
c4=0.0026;
TFinal=10;
w=0.5
[tSol1, maSol1, vSol1] = constantThrottleSim(22, 0.01,c1, c2, c3, c4, TFinal);
[tSol2, maSol2, vSol2] = constantThrottleSim(22, -0.01,c1, c2, c3, c4, TFinal);
[tSol3, maSol3, vSol3] = constantThrottleSim(22, 0.04,c1, c2, c3, c4, TFinal);
[tSol4, maSol4, vSol4] = constantThrottleSim(22, -0.04,c1, c2, c3, c4, TFinal);
[tSol5, maSol5, vSol5] = constantThrottleSim(22, 0.1,c1, c2, c3, c4, TFinal);
[tSol6, maSol6, vSol6] = constantThrottleSim(22, -0.1,c1, c2, c3, c4, TFinal);
[tSol7, maSol7, vSol7] = constantThrottleSim(32, 0.01,c1, c2, c3, c4, TFinal);
[tSol8, maSol8, vSol8] = constantThrottleSim(32, -0.01,c1, c2, c3, c4, TFinal);
[tSol9, maSol9, vSol9] = constantThrottleSim(32, 0.04,c1, c2, c3, c4, TFinal);
[tSol10, maSol10, vSol10] = constantThrottleSim(32, -0.04,c1, c2, c3, c4, TFinal);
[tSol11, maSol11, vSol11] = constantThrottleSim(32, 0.1,c1, c2, c3, c4, TFinal);
[tSol12, maSol12, vSol12] = constantThrottleSim(32, -0.1,c1, c2, c3, c4, TFinal);
figure;
hold on;
plot(tSol1,maSol1,tSol2,maSol2,tSol3,maSol3,tSol4,maSol4,tSol5,maSol5,tSol6,maSol6,tSol7,maSol7,tSol8,maSol8,tSol9,maSol9,'r',tSol10,maSol10,tSol11,maSol11,tSol12,maSol12);
%plot(tSol,d_vSol,'b-o','LineWidth',2);
%axis([-Inf Inf -1 1]);
xlabel('t');
ylabel('ma');
title('Plot of ma');
legend('ma Beta=0.01,vBar=22','ma Beta=-0.01,vBar=22','ma Beta=0.04,vBar=22','ma Beta=-0.04,vBar=22','ma Beta=0.1,vBar=22','ma Beta=-0.1,vBar=22','ma Beta=0.01,vBar=32','ma Beta=-0.01,vBar=32','ma Beta=0.04,vBar=32','ma Beta=-0.04,vBar=32','ma Beta=0.1,vBar=32','ma Beta=-0.1,vBar=32');
box on;
legend('boxoff');
hold off;

figure;
hold on;
plot(tSol1,vSol1,tSol2,vSol2,tSol3,vSol3,tSol4,vSol4,tSol5,vSol5,tSol6,vSol6,tSol7,vSol7,tSol8,vSol8,tSol9,vSol9,'r',tSol10,vSol10,tSol11,vSol11,tSol12,vSol12);
%plot(tSol,d_vSol,'b-o','LineWidth',2);
%axis([-Inf Inf -1 1]);
xlabel('t');
ylabel('v');
title('Plot of v');
legend('v Beta=0.01,vBar=22','v Beta=-0.01,vBar=22','v Beta=0.04,vBar=22','v Beta=-0.04,vBar=22','v Beta=0.1,vBar=22','v Beta=-0.1,vBar=22','v Beta=0.01,vBar=32','v Beta=-0.01,vBar=32','v Beta=0.04,vBar=32','v Beta=-0.04,vBar=32','v Beta=0.1,vBar=32','v Beta=-0.1,vBar=32');
box on;
legend('boxoff');
hold off;



end


