n = 80;
T = 1.25*252;
nE = 20*n;
rho = 0.03;
muc = 0.011^2;
sigmac = 0.001;
c0 = muc;
x0 = log(292.58);
deltaE = 1/nE;
delta = 1/n;

seed = 3005;
rng(seed,'twister');

c = simsv(c0,rho,muc,deltaE,sigmac,nE,T);

t = 0:deltaE:T;

f = figure(23);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,c);
title('the stimulated variance process');
box off; grid on;
xlabel('time/day');
ylabel('stochastic variance');
print(f,'-dpng','-r200','figures/3A1');
close(f);

% question C
c_a = reshape(c(2:end),nE,T);
IV = (1/nE)*sum(c_a);
t_day = 1:T;

f = figure(24);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t_day,IV*100);
title('the integrated variance');
box off; grid on;
xlabel('time/day');
ylabel('intergrated variance');
print(f,'-dpng','-r200','figures/3C1');
close(f);

%quesition D
x = simlp(c0,x0,rho,muc,sigmac,delta,n,T);

p = exp(x);

deltax = simlr(x,n,T);
deltax_a = reshape(deltax(2:end),n,T);
RV1 = realized_var(deltax_a);

f = figure(25);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t_day,RV1*100)
hold on
plot(t_day,IV*100);
hold off
legend('RV','IV')
title('realized variance and actual integrated variance');
box off; grid on;
xlabel('time');
ylabel('realized variance and integrated variance');
print(f,'-dpng','-r200','figures/3D');
close(f);

% question E
alpha = 0.05;
z = norminv([(alpha/2) (1-alpha/2)]);
QIV = sum((deltax_a).^4)*n/3;
CI_IV = RV1 + z(:).*sqrt(2/n*QIV);

f = figure(26);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t_day,CI_IV)
hold on
plot(t_day,IV);
hold off
legend('CI_IV','IV');
% datetick('x','yyyy');
title('confidence interval of integrated variance');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/3E');
close(f);

% %question F
q_1 = IV>=CI_IV(1,:);
w_1 = IV<=CI_IV(2,:);
days_1 = sum(and(q_1,w_1));
acr_1 = days_1/T;

%question G
lambda = 20/252;
N = poissrnd(lambda*T);
sigmaj = 30*sqrt(muc/N);
Y = normrnd(0,sigmaj,1,n*T);
U = unifrnd(0,1,1,n*T);

J = simcp(Y,U,N,n,T);
p = exp(x+J);
tp = 0:delta:T;

f = figure(27);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(tp,p)
title('the simulated prices with jumps');
box off; grid on;
xlabel('time');
ylabel('price');
print(f,'-dpng','-r200','figures/3G');
close(f);

%question H
r = diff(x+J);
r = reshape(r,n,T);
RV_j = realized_var(r);
QIV_j = n/3*sum(r.^4);
CI_j = ci_f(0.05,n,RV_j,QIV_j);
q_2 = IV>=CI_j(1,:);
w_2 = IV<=CI_j(2,:);
days_2 = sum(and(q_2,w_2));
acr_2 = days_2/T;

% question I
lambda = 1;
N = poissrnd(lambda*T);
sigmaj = 30*sqrt(muc/N);
Y = normrnd(0,sigmaj,1,n*T);
U = unifrnd(0,1,1,n*T);


J = simcp(Y,U,N,n,T);
p = exp(x+J);
tp = 0:delta:T;

f = figure(28);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(tp,p)
title('the simulated prices with jumps 2');
box off; grid on;
xlabel('time');
ylabel('price');
print(f,'-dpng','-r200','figures/3I');
close(f);

r = diff(x+J);
r = reshape(r,n,T);
RV_j = realized_var(r);
QIV_j = n/3*sum(r.^4);
CI_j = ci_f(0.05,n,RV_j,QIV_j);
q_3 = IV>=CI_j(1,:);
w_3 = IV<=CI_j(2,:);
days_3 = sum(and(q_3,w_3));
acr_3 = days_3/T;

