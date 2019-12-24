function ci = ci_f(alpha, mean, std)
z = norminv([(alpha/2) (1-alpha/2)]);
ci = mean+z(:).*std;
end

% 
