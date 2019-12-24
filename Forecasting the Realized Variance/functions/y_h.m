function y_hat = y_h(N,sigmax2,sigmau2,beta)
x_hat = normrnd(0, sqrt(sigmax2), 1, N);
u_hat = normrnd(0, sqrt(sigmau2), 1, N);
y_hat = x_hat .* beta + u_hat;
end