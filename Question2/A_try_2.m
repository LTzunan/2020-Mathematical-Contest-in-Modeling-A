x=linspace(0,0.000075,3);
v=80.2/60;
t=linspace(0,435.5/v+2/v,437.5*2/v+1);%linspace(0,435.5/v,435.5*2/v+1);
m=0;
sol=pdepe(m,@A_2pdefun,@A_2ic,@A_2bc,x,t);
T=sol(:,:,1);
surf(x,t,T)
xlabel('位置')
ylabel('time')
zlabel('T')
M=length(x);
tout=linspace(2/v,435.5/v+2/v,435.5*2/v+1);
[Tout,dTdx]=pdeval(m,t,T(:,M),tout);
Tout_end=Tout-273;
tout_end=tout;
plot(tout_end,Tout_end);
%hold on;
%plot(s,C)
