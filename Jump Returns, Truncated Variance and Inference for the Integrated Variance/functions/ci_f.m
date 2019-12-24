function ci = ci_f(alpha, n, mean, QIV)
z = norminv([(alpha/2) (1-alpha/2)]);
ci = mean+z(:).*sqrt(2/n*QIV);
end
