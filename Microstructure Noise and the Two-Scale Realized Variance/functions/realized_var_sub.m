function rv_subave = realized_var_sub(kn,prices)
rv_sub = zeros(kn,252);
for i = 1:kn
prices_sub = prices(i:kn:end,:);
deltax_sub = diff(prices_sub);
rv_sub(i,:) = realized_var(deltax_sub);
end
rv_subave = sum(rv_sub)/kn;
end