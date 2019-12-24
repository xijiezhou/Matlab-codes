function new_returns = bootstrap_stock(returns,n,T,kn,M)
indice = randi(kn,n,T);
interday_offset = repmat(0:n:(T-1)*n,n,1);

intraday_offset = repmat(0:kn:(M-1)*kn,kn,1);
intraday_offset = intraday_offset(:);

indice = indice + intraday_offset + interday_offset;

new_returns = returns(indice);

end

