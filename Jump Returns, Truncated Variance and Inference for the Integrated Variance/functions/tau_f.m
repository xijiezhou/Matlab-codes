function tau = tau_f(deltax)

[n,T] = size(deltax);
b_f = sum(abs(deltax(2:end,:).*deltax(1:n-1,:)),2)/T;

b1 = b_f(1:1);
b = [b1;b_f];

tau = n*b/sum(b);