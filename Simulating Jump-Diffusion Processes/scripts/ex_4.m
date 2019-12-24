n = 80;
T = 1.25*252;
nE = 20*n;
rho = 0.03;
muc = 0.011^2;
sigmac = 0.001;
c0 = muc;
delta = 1/n;

seed = 3005;
rng(seed,'twister');

x = zeros(nE*T+1,1);
x0 = log(292.58);

deltaE = 1/nE;
z = randn(nE*T+1,1);

% c = zeros(nE*T+1,1);
% for j = 1:nE*T 
%
%  c(j+1) = c(j) + rho*(muc-c(j))*deltaE+z(j+1)*sigmac*sqrt(c(j)*deltaE);
% end
% 
% for j = 1:nE*T
%    if c(j) < muc/2
%       c(j) = muc/2;
%    end
% end
c = simsv(c0,rho,muc,deltaE,sigmac,nE,T);

t = 0:deltaE:T;

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,c);
title('the stochastic variance process');
box off; grid on;
xlabel('time/day');
ylabel('stochastic variance');
print(f,'-dpng','-r200','figures/4B');
close(f);


% question C
% for j = 1:nE*T
%     x(j+1) = x(j)+sqrt(c(j)*deltaE)*z(j+1);
% end
x = simlp(c0,x0,rho,muc,sigmac,deltaE,nE,T);

p = exp(x);

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,p);
title('the ultra high frequency log-prices ');
box off; grid on;
xlabel('time/day');
ylabel('price');
print(f,'-dpng','-r200','figures/4C');
close(f);

% question D
% deltax = zeros(nE*T+1,1);
% for j = 1:nE*T
%     deltax(j) = x(j+1)-x(j);
% end
deltax = simlr(x,nE,T);

f = figure(3);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,100*deltax);
title('the ultra high frequency returns');
box off; grid on;
xlabel('time/day');
ylabel('returns%');
print(f,'-dpng','-r200','figures/4D');
close(f);

% question E
% xi = zeros(1+nE*T/n,1);
% xi(1) = x(1);
% for i = 1:n*T
%     xi(i+1) = x((i)*nE/n);
% end

% deltaxi = zeros(n*T+1,1);
% for j = 1:n*T
%     deltaxi(j) = x(j+1)-x(j);
% end
deltaxi = simlr(x,n,T);

t = 0:delta:T;

f = figure(4);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,100*deltaxi);
title('the simulated log_prices at a coarser frequency');
box off; grid on;
xlabel('time/day');
ylabel('returns%');
print(f,'-dpng','-r200','figures/4E');
close(f);
    

