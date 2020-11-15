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
K = 23;
z = 0.5;
Gc = tf(K*[1 z],[1 0]);
Go = series(Gp, Gc);
rlocus(Go)
%rlocfind(Go) % z=0.6, k=32
Gideal = tf(1,1);
Gcl = feedback(Go, Gideal);
%step(Gcl)
title("Step response of closed loop local LTI system")
%print('report/img/p2-step-Gcl','-dpng');
%% 6 i Fail low?
kl = K*0.01;
Gclow = tf(kl*[1 z],[1 0]);
Golow = series(Gp, Gclow);
Gcllow = feedback(Golow, Gideal);
%step(Gcllow)
title("Step response of fail low case")
%print('report/img/p2-step-fail-low','-dpng');
%% 6 ii Fail high?
kh = K*5;
Gchigh = tf(kh*[1 z],[1 0]);
Gohigh = series(Gp, Gchigh);
Gclhigh = feedback(Gohigh, Gideal);
%step(Gclhigh)
title("Step response of fail high case")
%print('report/img/p2-step-fail-high','-dpng');
%% 8 Step response
%lsim(Gcl, ones(length(0:0.01:10),1)', 0:0.01:10)
close all
eps = 0;
%fn = @(qin, t, xt) (C_d*A_d*sqrt(2*g))/A*(sqrt(x_r)-sqrt(x_r+xt)) + qin/A;
Kp = 1;
Ki = 1;
fn = @(eps, t, y) [0 y(2) 0;0 0 y(3); -Kp (-1/m*(k+3*eps*y(1)^2+Ki)) -d/m];
fn_ode = @(t,y) fn(eps,t,y);
[to, yo] = ode45(fn, [0 1], [0 0 0])