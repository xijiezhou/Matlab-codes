function booCorr = boost_correlation(J,T,n,kn,M,rc1,rc2,rcm)
booCorr = zeros(J,T);
for j = 1:J
    ranidice = randi(kn,n,T);
    intraday = repmat(0:kn:(M-1)*kn,kn,1);
    intraday = reshape(intraday,n,1);
    interday = repmat(0:n:(T-1)*n,n,1);
    indices = ranidice + intraday + interday;
    new_rc_1 = rc1(indices);
    new_rc_2 = rc2(indices);
    new_rc_m = rcm(indices);
    new_realized_beta_1 = sum((new_rc_m.*new_rc_1))./sum(new_rc_m.^2);
    new_realized_beta_2 = sum((new_rc_m.*new_rc_2))./sum(new_rc_m.^2);
    new_e_1 = new_rc_1 - new_realized_beta_1.*new_rc_m;
    new_e_2 = new_rc_2 - new_realized_beta_2.*new_rc_m;
    new_rho = zeros(1,T);
    for i = 1:T
        new_rho(i) = corr(new_e_1(:,i),new_e_2(:,i));
    end
    booCorr(j,:) = new_rho;
end
    