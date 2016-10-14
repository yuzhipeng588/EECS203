function tSol=simAndAnimate(aSeq,deltaFSeq)
%aSeq= a ;
%deltaFSeq=deltaF;
initState=[0 0 0 0];
TS=0.1;
[xE, yE, vE, psiE] = bikeFEsim(aSeq, deltaFSeq, initState, TS);
tSol=zeros(length(xE),1);
for i=2:length(xE)
    tSol(i)=tSol(i-1)+TS;
end
subplot(2,2,1)
plot(tSol, xE, 'r', tSol, yE, 'k');
legend('x1','x2','location','Best');
xlabel('Time, t')
ylabel('Both Solutions x(t)')
subplot(2,2,2)
plot(xE, yE, 'b');
xlabel('x1')
ylabel('x2')
subplot(2,2,3)
plot(tSol, xE, 'r');
xlabel('Time, t')
ylabel('x1(t)')
subplot(2,2,4)
plot(tSol,  yE, 'k');
xlabel('Time, t')
ylabel('x2(t)')

end