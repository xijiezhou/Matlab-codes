n = 80;%number of samples
T = 1.25*252;
sigma = 0.011;%lognormal sigma parameter
Lambda = 15/252;%Poisson lambda parameter
sigmaj = 18*sqrt(sigma*sigma/n);
Y = normrnd(0,sigmaj,1,n*T);%create normal random numbers
N = poissrnd(Lambda*T);%create random numbers from Poisson distribution
U = unifrnd(0,1,1,n*T);%create continuous uniform random numbers
delta = 1/n;%discretization interval

seed = 3005;
rng(seed,'twister');

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

t = 0:delta:T;

f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(t,J);
title('the compound Poisson process');
box off; grid on;
xlabel('time/day');
ylabel('jumps');
print(f,'-dpng','-r200','figures/2B');
close(f);
