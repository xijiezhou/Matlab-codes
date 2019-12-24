[dates_1, prices_1] = load_stock('PG.csv');
[dates_2, prices_2] = load_stock('SPY.csv');
% question A
[dates_return_1,deltax_1] = log_returns(dates_1, prices_1);
[dates_return_2,deltax_2] = log_returns(dates_2, prices_2);
[n,T] = size(deltax_1);
deltan = 1/n;
tau_1 = tau_f(deltax_1);
tau_2 = tau_f(deltax_2);

BV_1 = bipower_var(deltax_1);
BV_2 = bipower_var(deltax_2);

alpha = 4.5;
cutoff_1 = alpha*deltan^0.49*sqrt(tau_1*BV_1);
cutoff_2 = alpha*deltan^0.49*sqrt(tau_2*BV_2);

rc_1 = deltax_1;
rc_1(abs(deltax_1)>cutoff_1)=0;

rc_2 = deltax_2;
rc_2(abs(deltax_2)>cutoff_2)=0;

realized_beta = sum((rc_1.*rc_2))./sum(rc_1.^2);

f = figure(8);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_1,realized_beta)
datetick('x','yyyy');
legend('realized_beta');
title('realized betas of PG with SPY');
box off; grid on;
xlabel('time');
ylabel('realized betas');
print(f,'-dpng','-r200','figures/2A2');
close(f);

% question C
kn = 11;
M = 7;

J = 10000;
booRB = boost_realized_beta(J,T,n,kn,M,rc_1,rc_2);

RB_CI = ci_f(0.05,mean(booRB),std(booRB));

f = figure(9);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_1(1,:),RB_CI(1,:))
hold on
plot(dates_1(1,:),RB_CI(2,:))
plot(dates_1(1,:),realized_beta)
hold off
datetick('x','yyyy');
legend('RB_CI_lower','RB_CI_higher','realized_beta');
title('confidence interval of realized beta of PG with SPY');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2C2');
close(f);

% question D
zoom_start = find(dates_return_1==datenum(2008,10,1,16,0,0))/n;
zoom_end = find(dates_return_1==datenum(2008,10,31,16,0,0))/n;
realized_beta_zoom = realized_beta(zoom_start:zoom_end); 
RB_CI_zoom = RB_CI(:,zoom_start:zoom_end);
dates_zoom = dates_return_1(1,zoom_start:zoom_end);

f = figure(10);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom(1,:),RB_CI_zoom(1,:))
hold on
plot(dates_zoom(1,:),RB_CI_zoom(2,:))
plot(dates_zoom(1,:),realized_beta_zoom)
hold off
datetick('x','mmdd');
legend('RB_CI_lower','RB_CI_higher','realized_beta');
title('confidence interval of realized beta in one month of PG with SPY');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2D2');
close(f);

% question E
% confidence interval is below 1
beta_2 = length(find(RB_CI(2,:)<1));
% confidence interval is above 1
beta_3 = length(find(RB_CI(1,:)>1));
% confidence interval contains 1
beta_1 = T-beta_2-beta_3;
