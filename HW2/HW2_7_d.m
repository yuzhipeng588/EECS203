A=zeros(length(RoomTempData)-1,2);
b=zeros(length(RoomTempData)-1,1);
for k=1:length(RoomTempData)-1
    A(k,1)=-1*FanData(k,2)*RoomTempData(k,2);
    A(k,2)=FanData(k,2)*SupplyTempData(k,2);
    b(k)=RoomTempData(k+1,2)-RoomTempData(k,2);   
end
pNew=A\b;