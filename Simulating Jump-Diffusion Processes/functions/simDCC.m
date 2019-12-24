function x = simDCC(x0,mu,delta,sigma,n,T)
x = [x0;zeros(n*T,1)];
z = normrnd(0,1,n*T,1);
for i = 1:n*T
x(i+1) = x(i) + mu*delta + sigma*sqrt(delta)*z(i);
end