function TV = tv_f(deltax,)
[n,T] = size(deltax);
deltan = 1/n;
tau = tau_f(deltax);
BV = bipower_var(deltax);
alpha = 4;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;

TV = sum((rc).^2);