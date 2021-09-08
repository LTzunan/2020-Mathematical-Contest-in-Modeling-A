x=linspace(0,0.000075,3);
v=70/60;
t=linspace(19,373,709);
m=0;
sol=pdepe(m,@A_1pdefun,@A_1ic,@A_1bc,x,t);
T=sol(:,:,1);
surf(x,t,T)
xlabel('位置')
ylabel('time')
zlabel('T')
M=length(x);
tout=linspace(19,373,709);
[Tout,dTdx]=pdeval(m,t,T(:,M),tout);
Tout_end=Tout-273;
tout_end=tout;
plot(tout_end,Tout_end);
%hold on;
%plot(s,C)
SSE=sum((C-reshape(Tout_end,709,1)).^2); %残差平⽅和
disp(['SSE=', num2str(SSE)]);
R=max(abs(reshape(Tout_end,709,1)-C)); %极差
disp(['R=', num2str(R)]);
