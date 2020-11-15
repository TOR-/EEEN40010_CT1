%% Constants, setup
a=4;
b=6;
c=6;

m = a+b+c;
d = 5.3*c;
k=0.5*(a+2*c);
eps = 1; % only defined as non-negative

set(gca, 'defaultTextInterpreter','latex')
set(gca, 'FontSize',54)
close all
%% 2
% x = [y~ ; dy~/dt]
% u = [F~]
A = [0 1 ; -k/m -d/m];
B = [0 ; 1/m];
C = [1 0];
D = [0];
Gp = ss(A,B,C,D);
%% 4 P I? D? Controller
% PI
k = 23;
z = 0.5;
Gc = tf(k*[1 z],[1 0]);
Go = series(Gp, Gc);
rlocus(Go)
%rlocfind(Go) % z=0.6, k=32
Gideal = tf(1,1);
Gcl = feedback(Go, Gideal);
step(Gcl)
title("Step response of closed loop local LTI system")
%print('report/img/p2-step-Gcl','-dpng');
%% 6 i Fail low?
kl = k*0.01;
Gclow = tf(kl*[1 z],[1 0]);
Golow = series(Gp, Gclow);
Gcllow = feedback(Golow, Gideal);
%step(Gcllow)
%% 6 ii Fail high?
kh = k*5;
Gchigh = tf(kh*[1 z],[1 0]);
Gohigh = series(Gp, Gchigh);
Gclhigh = feedback(Gohigh, Gideal);
%step(Gclhigh)
%% 8 Step response
%lsim(Gcl, ones(length(0:0.01:10),1)', 0:0.01:10)