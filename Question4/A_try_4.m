x=linspace(0,0.000075,3);
v=83.6/60;
step=100;
pass=-1;
sumt1=0;
sumt2=0;
maxT=0;
reve_i=0;
maxi=0;
S=0;
t_reve=[];
T_reve=[];
T_origin=[];
t=linspace(0,435.5/v+2/v,437.5*step/v+1);%linspace(0,435.5/v,435.5*2/v+1);
m=0;
sol=pdepe(m,@A_4pdefun,@A_4ic,@A_4bc,x,t);
T=sol(:,:,1);
surf(x,t,T)
xlabel('位置')
ylabel('time')
zlabel('T')
M=length(x);
tout=linspace(2/v,435.5/v+2/v,435.5*step/v+1);
[Tout,dTdx]=pdeval(m,t,T(:,M),tout);
Tout_end=Tout-273;
tout_end=tout;
plot(tout_end,Tout_end);
hold on

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
        maxi=i;
    end
    if((Tout_end(i)<217)&&(Tout_end(i+1)>217))
        reve_i=i+1;
    end
    if((Tout_end(i)>217)&&(Tout_end(i+1)<217))
        if((i-maxi)<(maxi-reve_i))
            reve_i=2*maxi-i;
        end
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
    disp(['sumt2=', num2str(sumt2/2)]);
end
if(sumt2>90*step)
    pass=1;
    disp("温度大于217ºC的时间大于90s");
    disp(['sumt2=', num2str(sumt2/2)]);
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
    for i=1:length(tout_end)-1
        if((reve_i<i)&&(i<=maxi))
            t_reve=[t_reve tout_end(i)];
            T_origin=[T_origin Tout_end(i)];
        end
        if((maxi<=i)&&(i<(2*maxi-reve_i)))
            T_reve=[T_reve Tout_end(i)];
        end
    end
    T_reve=fliplr(T_reve);
    plot(t_reve,T_reve);
    xlabel('t');
    ylabel('T');
    SSE=sum((T_origin-T_reve).^2); %残差平方和
    disp(['SSE=', num2str(SSE)]);
    R=max(abs(T_origin-T_reve));%极差
    disp(['R=', num2str(R)]);
    disp(['面积为', num2str(S),'cm^2']);
end
