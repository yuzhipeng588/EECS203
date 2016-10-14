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