% A
[dates_1, prices_1] = load_stock('DIS.csv');
[dates_2, prices_2] = load_stock('PG.csv');

[dates_return_1,deltax_1] = log_returns(dates_1, prices_1);
[dates_return_2,deltax_2] = log_returns(dates_2, prices_2);
[n,T] = size(deltax_1);
deltan = 1/n;

r_long_short = deltax_1-deltax_2;

tau_r_long_short = tau_f(r_long_short);
BV_r_long_short = bipower_var(r_long_short);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau_r_long_short*BV_r_long_short);
rc_long_short = r_long_short;
rc_long_short(abs(r_long_short)>cutoff)=0;

average_rc_long_short = mean(rc_long_short(:));
min_rc_long_short = min(rc_long_short(:));
p5_rc_long_short = quantile(rc_long_short(:),0.05);
p95_rc_long_short = quantile(rc_long_short(:),0.95);
max_rc_long_short = max(rc_long_short(:));

% B
[dates_m, prices_m] = load_stock('SPY.csv');
[dates_return_m,deltax_m] = log_returns(dates_m, prices_m);
tau_m = tau_f(deltax_m);
BV_m = bipower_var(deltax_m);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau_m*BV_m);
rc_m = deltax_m;
rc_m(abs(deltax_m)>cutoff)=0;

realized_beta = sum((rc_m.*rc_long_short))./sum(rc_m.^2);

average_realized_beta = mean(realized_beta(:));
min_realized_beta = min(realized_beta(:));
p5_realized_beta = quantile(realized_beta(:),0.05);
p95_realized_beta = quantile(realized_beta(:),0.95);
max_realized_beta= max(realized_beta(:));

% C
kn = 11;
M = 7;

J = 1000;
booRB = boost_realized_beta(J,T,n,kn,M,rc_m,rc_long_short);

RB_CI = ci_f(0.05,mean(booRB),std(booRB));

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_m(1,:),RB_CI(1,:))
hold on
plot(dates_m(1,:),RB_CI(2,:))
plot(dates_m(1,:),realized_beta)
hold off
datetick('x','yyyy');
legend('RB_CI_lower','RB_CI_higher','realized_beta');
title('confidence interval of realized beta of long-short returns');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2C1');
close(f);

% D
zoom_start = find(dates_return_1==datenum(2008,10,1,16,0,0))/n;
zoom_end = find(dates_return_1==datenum(2008,10,31,16,0,0))/n;
realized_beta_zoom = realized_beta(zoom_start:zoom_end); 
RB_CI_zoom = RB_CI(:,zoom_start:zoom_end);
dates_zoom = dates_return_1(1,zoom_start:zoom_end);


f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom(1,:),RB_CI_zoom(1,:))
hold on
plot(dates_zoom(1,:),RB_CI_zoom(2,:))
plot(dates_zoom(1,:),realized_beta_zoom)
hold off
legend('lower bound','higer bound','realized beta')
% xticks(1:23)
% xticklabels({'1','2','3','7','8','9','10','11','14','15','16','17','18','21','22','23','24','25','28','29','30','31'})
datetick('x','mmdd');
title('confidence interval of realized beta of long-short returns in one month');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2D1');
close(f);

% E
contain_0 = zeros(1,T);
for i = 1:T
    contain_0(i) = RB_CI(1,i)<0 && RB_CI(2,i)>0;
end

sum_contain_0 = sum(contain_0);
not_contaion_0 = T - sum_contain_0;
p_not_contaion_0 = not_contaion_0/T;













