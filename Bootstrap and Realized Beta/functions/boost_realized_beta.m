function booRB = boost_realized_beta(J,T,n,kn,M,rc1,rc2)
booRB = zeros(J,T);
for j = 1:J
    ranidice = randi(kn,n,T);
    intraday = repmat(0:kn:(M-1)*kn,kn,1);
    intraday = reshape(intraday,n,1);
    interday = repmat(0:n:(T-1)*n,n,1);
    indices = ranidice + intraday + interday;
    new_rc_1 = rc1(indices);
    new_rc_2 = rc2(indices);
    booRB(j,:) = sum((new_rc_1.*new_rc_2))./sum(new_rc_1.^2);
end
