function rv_s = realized_var_s(kn,prices)
prices_s = prices(1:kn:end,:);
deltax_s = diff(prices_s);
rv_s = realized_var(deltax_s);
end
