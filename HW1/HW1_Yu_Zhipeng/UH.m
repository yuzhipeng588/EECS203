function uhsol=UH(t)
uhsol=zeros(2,1);
uhsol(1)=1000*(2 + sin(0.1*t));
uhsol(2)= 25 + sin(0.2*t);
end