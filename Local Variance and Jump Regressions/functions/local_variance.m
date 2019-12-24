function c_hat = local_variance(returns,time,n,kn)
c_hat = zeros(1,time);
for i = 1:n
num1 = i - 1;
num2 = n - i;
j1 = min(kn,num1); 
j2 = min(kn,num2);
returns_intv = returns(i-j1:i+j2,:);
c_hat(i,:) = sum(returns_intv .^2)/((j1+j2+1)*(1/n));
end