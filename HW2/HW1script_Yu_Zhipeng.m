%% ME C231A, EECS C220B, Problem Set #1, OPT1
% Follow this format to organize the script file which "manages" all of the
% tasks in producing HW1.  Conclude by *publishing* this file, and then
% printing the resulting html file to pdf.  Turn the pdf file
% (electronically) in via bCourses (more instructions later).

%% Problem 1
% Simulation and Linearization of Engine/Drivetrain model

%% 4
% Plot Throttle characteristic
f = ones(3,1);
A = [-1 0 0; 0 -1 0; 0 0 -1; -1 1 -1];
b = [-2;1;3;-4];
[x1,fval] = linprog(f,A,b);
f = ones(3,1);
A = [-1 1 -1];
b = -4;
LB = [2;-1;-3];
[x2,fval] = linprog(f,A,b,[],[],LB,[]);
fprintf('x1 and x2 are different local minimum with the same cost \n');


%% 5
A=eye(5);
b=ones(5,1);
H = 2*A'*A;
f = -2*A'*b;
x_cls = quadprog(H, f, [eye(5);-eye(5)], [0.5*ones(5,1);0.5*ones(5,1)]);
x_ls = A\b; % get standard least-squares solution
x_ls(x_ls>0.5) = 0.5; % set any entries that are greater than 0.5 to 0.5
x_ls(x_ls<-0.5) = -0.5; % set any entries that are less than -0.5 to -0.5
% Compare performance (ie., cost function) to direct solution from QUADPROG
disp(norm(A*x_cls-b));
disp(norm(A*x_ls-b));
fprintf('Two methods has the same solution.\n');
%% 6
fprint('read \n');
%% 7(a)
% |constantThrottleLinearSim| is autograded.  In this section, carry out
% the simulations, and format the plots nicely.
f1=figure(1);
hold on
set(f1,'name','HW2_7(a)','Numbertitle','off');
xData = cumsum([0 0.1+rand(1,19)]);
yData = [sort(3*rand(1,10)) fliplr(sort(3*rand(1,10)))];
xQuery = 0.1:0.2:max(xData);
yInterpLinear = interp1(xData, yData, xQuery);
yInterpSpline = interp1(xData, yData, xQuery, 'spline');
subplot(2,1,1)
plot(xData, yData, 'k*', xQuery, yInterpLinear, '-or')
legend('Data Points', 'Linear Interpolated Values', 'Location','Best');
ylabel('y')
subplot(2,1,2)
plot(xData, yData, 'k*', xQuery, yInterpSpline, '-or')
legend('Data Points', 'Spline Interpolated Values', 'Location','Best');
xlabel('x')
ylabel('y')
box on
hold off
%HW2_7(b)
%HW2_7(c)
f2=figure(2);
set(f2,'name','HW2_7(c))','Numbertitle','off');
p= bldgIdentification(RoomTempData(:,2), FanData(:,2), SupplyTempData(:,2));
NewRoomTemData=zeros(1,length(RoomTempData));
NewRoomTemData(1)=RoomTempData(1,2);
for k=1:length(RoomTempData)-1
    NewRoomTemData(k+1)=((1-p(1)*FanData(k,2))*RoomTempData(k,2) + p(2)*FanData(k,2)*SupplyTempData(k,2));   
end
plot(RoomTempData(:,1), RoomTempData(:,2),'r',RoomTempData(:,1), NewRoomTemData,'b');
datetick('x')
ylabel('RoomTemp')

%% 7(b)
f2=figure(2);
set(f2,'name','HW2_7(c))','Numbertitle','off');
p= bldgIdentification(RoomTempData(:,2), FanData(:,2), SupplyTempData(:,2));
NewRoomTemData=zeros(1,length(RoomTempData));
NewRoomTemData(1)=RoomTempData(1,2);
for k=1:length(RoomTempData)-1
    NewRoomTemData(k+1)=((1-p(1)*FanData(k,2))*RoomTempData(k,2) + p(2)*FanData(k,2)*SupplyTempData(k,2));   
end
plot(RoomTempData(:,1), RoomTempData(:,2),'r',RoomTempData(:,1), NewRoomTemData,'b');
datetick('x')
ylabel('RoomTemp');
box on
hold off;
%% 8(b)
% Stability of specific discrete-time system.  |isSystemStable| is
% autograded.   Illustrate its behavior here for a few values of |alpha|
fprintf('2 all good \n');
for alpha=[0.01 0.2 3 10];
    [TF] = isSystemStable(alpha);
    fprintf('alpha=%d,TF=%i \n',alpha,all(TF));
end
%% Problem 3
A1=[1,0;0,1];
b1=[0;-5];
Ainf=[1,0;0,1];
binf=[2;0];
Ac=[3,2;1,0;-1,0;0,1;0,-1];
bc=[-3;2;0;3;2];
[xOpt, J] = reg1Inf(A1, b1, Ainf, binf, Ac, bc);


%% Attribution
% Include you name, date and the class number.
% Zhipeng Yu ,2016/9/4 ME231A
fprintf('Zhipeng Yu ,2016/9/4 ME231A');
