p= bldgIdentification(RoomTempData(:,2), FanData(:,2), SupplyTempData(:,2));
NewRoomTemData=zeros(1,length(RoomTempData));
NewRoomTemData(1)=RoomTempData(1,2);
for k=1:length(RoomTempData)-1
    NewRoomTemData(k+1)=((1-p(1)*FanData(k,2))*RoomTempData(k,2) + p(2)*FanData(k,2)*SupplyTempData(k,2));   
end
plot(RoomTempData(:,1), RoomTempData(:,2),'r',RoomTempData(:,1), NewRoomTemData,'b');
datetick('x')
ylabel('RoomTemp')
