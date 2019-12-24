n = 80;
T = 1.25*252;
mu = 0.03782/100;
sigma = 0.011;
delta = 1/n;
Lambda = 15/252;
sigmaj = 18*sqrt(sigma*sigma/n);
Y = normrnd(0,sigmaj,1,n*T);
N = poissrnd(Lambda*T);
U = unifrnd(0,1,1,n*T);
z = randn(n*T+1,1);
x0 = log(292.58);

seed = 3005;
rng(seed,'twister');

% x = zeros(n*T+1,1);
% x(1) = log(292.58);
% for i = 1:n*T
% x(i+1) = x(i) + mu*delta + sigma*sqrt(delta)*z(i+1);
% end
x = simDCC(x0,mu,delta,sigma,n,T);

% J = zeros(n*T+1,1);
% for i = 0:n*T
%     for k = 1:N
%      if U(k) <= i/(n*T)
%             J(i+1) = J(i+1)+Y(k);
%      else
%             J(i+1) = J(i+1);
%      end
%     end
% end
J = simcp(Y,U,N,n,T);

p = exp(x+J);
t = 0:delta:T;

f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,p)
title('the jump-diffusion model with constant coefficients');
box off; grid on;
xlabel('time/day');
ylabel('price');
print(f,'-dpng','-r200','figures/3B');
close(f);


