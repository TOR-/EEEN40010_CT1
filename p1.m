%% Constants, setup
a=4;
b=6;
c=6;

set(gca, 'defaultTextInterpreter','latex')
set(gca, 'FontSize',54)
close all
%% Spec
Np = 6*a.*[1 5*a+c];
Dp = conv([1 4.1*a],[1 8.2*a+2*b+c]);
Gp = tf(Np,Dp);

sip = stepinfo(Gp);
polemin = -1/(sip.SettlingTime*0.8/4);
fprintf(1, "Maximum pole location: %f\n", polemin);

%% Controllers
% PI ?
%Gc = tf([1 -polemin],[1]); % with unit gain
%Go = series(Gp,Gc);
%rlocus(Go)
%rlocfind(Go)
%k = 3;

%Gideal = tf(1,1);
%Gcl = feedback(k*Go, Gideal);
%pole(Gcl)
%step(Gcl);

% PD ?
%k = 1;
%z = 16;
%p = 10;
%Gc = tf(k*[1 z],[1 p]);
%rlocus(Go)
%rlocfind(Go)
%Go = series(Gp,Gc);
%k=4.1;
%k = 500;
%Gcl = feedback(k*Go, Gideal);
%step(Gcl)

%% PID
k = 0.005;
z1 = 60;
z2 = 55;
Gc = tf(k*conv([1 z1],[1 z2]),[1 0]);
Go = series(Gp, Gc);
Gcl = feedback(Go, Gideal);
rlocus(Go)
rlocfind(Go)
step(Gcl)