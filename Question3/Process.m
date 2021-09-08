step=100;
pass=-1;
sumt1=0;
sumt2=0;
maxT=0;
S=0;
for i=1:length(tout_end)-1
    if((150 <= Tout_end(i))&&(Tout_end(i)<190)&&(Tout_end(i)<Tout_end(i+1)))
        sumt1=sumt1+1;
    end
    if(Tout_end(i)>217)
        sumt2=sumt2+1;
    end
    if(Tout_end(i)>maxT)
        maxT=Tout_end(i);
        maxt=tout_end(i);
    end
    if((Tout_end(i+1)-Tout_end(i))/(tout_end(i+1)-tout_end(i))) > 3
        pass=1;
        disp("温度上升斜率大于３");
        disp(['T=', num2str(Tout_end(i))]);
        disp(['t=', num2str(tout_end(i))]);
    end
    if((Tout_end(i+1)-Tout_end(i))/(tout_end(i+1)-tout_end(i))) < -3
        pass=1;
        disp("温度下降斜率小于-３");
        disp(['T=', num2str(Tout_end(i))]);
        disp(['t=', num2str(tout_end(i))]);
    end
    if(pass==1)
        break
    end
end
if(sumt1<60*step)
    pass=1;
    disp("温度上升过程中在150ºC~190ºC的时间小于60s");
    disp(['sumt1=', num2str(sumt1/step)]);
end
if(sumt1>120*step)
    pass=1;
    disp("温度上升过程中在150ºC~190ºC的时间大于120s");
    disp(['sumt1=', num2str(sumt1/step)]);
end
if(sumt2<40*step)
    pass=1;
    disp("温度大于217ºC的时间小于40s");
    disp(['sumt2=', num2str(sumt2/step)]);
end
if(sumt2>90*step)
    pass=1;
    disp("温度大于217ºC的时间大于90s");
    disp(['sumt2=', num2str(sumt2/step)]);
end
if(maxT<240)
    pass=1;
    disp("峰值温度小于240");
    disp(['maxT=', num2str(maxT)]);
end
if(maxT>250)
    pass=1;
    disp("峰值温度大于250");
    disp(['maxT=', num2str(maxT)]);
end
if(pass==-1)
    for i=1:length(tout_end)-1
        if ((Tout_end(i)<217) || (tout_end(i)>maxt))
            continue
        else
            S=S+(Tout_end(i)-217)/step;
        end 
    end
    disp(['面积为', num2str(S),'cm^2']);
end
