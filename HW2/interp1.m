function y=interp1(varargin)
 xData=zeros(1,length(varargin{1}));
 yData=zeros(1,length(varargin{2}));
 xQuery=zeros(1,length(varargin{3}));
 xData=varargin{1};
 yData=varargin{2};
 xQuery=varargin{3};
 y=zeros(1,length(xQuery));
 %xQuery = xData(1,1):1/1440:max(xData);
if (length(varargin)==3)
    for i=1:length(xQuery)
        for j=1:length(xData)
            if(xQuery(i)>=xData(j))
                y(i)=yData(j)+(yData(j+1)-yData(j))*(xQuery(i)-xData(j))/(xData(j+1)-xData(j));
            end
        end
    end
end
if (length(varargin)==4)
    y=spline(xData,yData,xQuery);
end
end