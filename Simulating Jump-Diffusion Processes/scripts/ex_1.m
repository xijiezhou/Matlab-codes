n = 80;%steps per day
T = 1.25*252;%the whole days
mu = 0.03782/100;%local predictable risk premuim parameter
sigma = 0.011;%the risk of the outcome paramter
delta = 1/n;%discretization interval
x0 = log(292.58);

seed = 3005;
rng(seed,'twister');

% x = zeros(n*T+1,1);%create zero filled array
% z = randn(n*T+1,1);%create normal distribution
% x(1) = log(292.58);%define x(0)
% 
% %simulate the process
% for i = 1:n*T
% x(i+1) = x(i) + mu*delta + sigma*sqrt(delta)*z(i+1);
% end
x = simDCC(x0,mu,delta,sigma,n,T);

%p = exp(x);%create price

t = 0:delta:T;%time axis

%plot
f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,exp(x));
title('the Gaussian diffusion model with constant coefficients');
box off; grid on;
xlabel('time/day');
ylabel('price');
print(f,'-dpng','-r200','figures/1B');
close(f);
