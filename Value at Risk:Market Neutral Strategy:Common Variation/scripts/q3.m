% A
[dates_1, prices_1] = load_stock('DIS.csv');
[dates_2, prices_2] = load_stock('PG.csv');
[dates_m, prices_m] = load_stock('SPY.csv');

[dates_return_1,deltax_1] = log_returns(dates_1, prices_1);
[dates_return_2,deltax_2] = log_returns(dates_2, prices_2);
[dates_return_m,deltax_m] = log_returns(dates_m, prices_m);

[n,T] = size(deltax_1);
deltan = 1/n;

tau_1 = tau_f(deltax_1);
tau_2 = tau_f(deltax_2);
tau_m = tau_f(deltax_m);

BV_1 = bipower_var(deltax_1);
BV_2 = bipower_var(deltax_2);
BV_m = bipower_var(deltax_m);

alpha = 5;
cutoff_1 = alpha*deltan^0.49*sqrt(tau_1*BV_1);
cutoff_2 = alpha*deltan^0.49*sqrt(tau_2*BV_2);
cutoff_m = alpha*deltan^0.49*sqrt(tau_m*BV_m);

rc_1 = deltax_1;
rc_1(abs(deltax_1)>cutoff_1)=0;

rc_2 = deltax_2;
rc_2(abs(deltax_2)>cutoff_2)=0;

rc_m = deltax_m;
rc_m(abs(deltax_m)>cutoff_2)=0;

average_1 = mean(rc_1(:));
min_1 = min(rc_1(:));
p5_1 = quantile(rc_1(:),0.05);
p95_1 = quantile(rc_1(:),0.95);
max_1 = max(rc_1(:));

average_2 = mean(rc_2(:));
min_2 = min(rc_2(:));
p5_2 = quantile(rc_2(:),0.05);
p95_2 = quantile(rc_2(:),0.95);
max_2 = max(rc_2(:));

average_m = mean(rc_m(:));
min_m = min(rc_m(:));
p5_m = quantile(rc_m(:),0.05);
p95_m = quantile(rc_m(:),0.95);
max_m = max(rc_m(:));

% B
rd_m = deltax_m;
rd_m(abs(deltax_m)<=cutoff_m)=0;

jumps = sum(rd_m~=0);
y = zeros(12,1);
[yyyy,mm,dd]= ymd_f('SPY.csv');
for i = 1:11
    y(i+1) = sum(ismember(yyyy,2006+i));
end
jumps_y = zeros(11,1);
for i = 1:11
    jumps_y(i) = sum(jumps(1,(sum(y(1:i))+1):sum(y(1:i+1))));
end
sum_jumps_y = sum(jumps_y);

% C
realized_beta_1 = sum((rc_m.*rc_1))./sum(rc_m.^2);
realized_beta_2 = sum((rc_m.*rc_2))./sum(rc_m.^2);

average_rb_1 = mean(realized_beta_1(:));
min_rb_1 = min(realized_beta_1(:));
p5_rb_1 = quantile(realized_beta_1(:),0.05);
p95_rb_1 = quantile(realized_beta_1(:),0.95);
max_rb_1 = max(realized_beta_1(:));

average_rb_2 = mean(realized_beta_2(:));
min_rb_2 = min(realized_beta_2(:));
p5_rb_2 = quantile(realized_beta_2(:),0.05);
p95_rb_2 = quantile(realized_beta_2(:),0.95);
max_rb_2 = max(realized_beta_2(:));

% D
f = figure(3);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_1,realized_beta_1)
datetick('x','yyyy');
legend('realized_beta');
title('realized betas of DIS with SPY');
box off; grid on;
xlabel('time');
ylabel('realized betas');
print(f,'-dpng','-r200','figures/3D1');
close(f);

f = figure(4);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_2,realized_beta_2)
datetick('x','yyyy');
legend('realized_beta');
title('realized betas of PG with SPY');
box off; grid on;
xlabel('time');
ylabel('realized betas');
print(f,'-dpng','-r200','figures/3D2');
close(f);

% E
e_1 = rc_1 - realized_beta_1.*rc_m;

e_2 = rc_2 - realized_beta_2.*rc_m;

rho = zeros(1,T);
for i = 1:T
rho(i) = corr(e_1(:,i),e_2(:,i));
end

average_rho = mean(rho(:));
min_rho = min(rho(:));
p5_rho = quantile(rho(:),0.05);
p95_rho = quantile(rho(:),0.95);
max_rho = max(rho(:));

% F
kn = 11;
M = 7;

J = 1000;

new_rho = boost_correlation(J,T,n,kn,M,rc_1,rc_2,rc_m);

CI_new_rho = ci_f(0.05,mean(new_rho),std(new_rho));

f = figure(5);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_m(1,:),CI_new_rho(1,:))
hold on
plot(dates_m(1,:),CI_new_rho(2,:))
plot(dates_m(1,:),rho)
hold off
datetick('x','yyyy');
legend('CI_lower','CI_upper','correlation');
title('confidence interval of correlations');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/3F');
close(f);

% G
zoom_start = find(dates_return_1==datenum(2008,10,1,16,0,0))/n;
zoom_end = find(dates_return_1==datenum(2008,10,31,16,0,0))/n;
rho_zoom = rho(zoom_start:zoom_end); 
CI_new_rho_zoom = CI_new_rho(:,zoom_start:zoom_end);
dates_m_zoom = dates_m(1,zoom_start:zoom_end);

f = figure(6);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_m_zoom(1,:),CI_new_rho_zoom(1,:))
hold on
plot(dates_m_zoom(1,:),CI_new_rho_zoom(2,:))
plot(dates_m_zoom(1,:),rho_zoom)
hold off
datetick('x','mmdd');
legend('Rho_CI_lower','Rho_CI_higher','rho');
title('confidence interval of correlations in one month');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/3G');
close(f);

% H
p_1 = (length(find(CI_new_rho(1,:)>0)))/252;
p_2 = (length(find(CI_new_rho(2,:)<0)))/252;
p_0 = (T-p_1-p_2)/252;
