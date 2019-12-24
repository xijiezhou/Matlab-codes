% question A
[dates, prices] = load_stock('DIS.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;

tau = tau_f(deltax);
BV = bipower_var(deltax);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);

rc = deltax;
rc(abs(deltax)>cutoff)=0;
rd = deltax;
rd(abs(deltax)<=cutoff)=0;

kn = 11;
[c_hat_minus,c_hat_plus,dates_j,rd_j] = local_variance_j(dates_return,rc,rd,n,T,kn);

f = figure(5);
subplot(2,1,1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_j,c_hat_minus);
hold on
plot(dates_j,c_hat_plus);
hold off
datetick('x','yyyy');
legend('before the jump','after the jump')
title('The jump local variance of DIS');
box off; grid on;
xlabel('time');
ylabel('local variance');

subplot(2,1,2);
bar(dates_j,abs(rd_j));
datetick('x','yyyy');
box off; grid on;
xlabel('time')
ylabel('The absolute value of Returns')
title('The absolute Value of Jump Returns of DIS');

print(f,'-dpng','-r200','figures/2A1');
close(f);