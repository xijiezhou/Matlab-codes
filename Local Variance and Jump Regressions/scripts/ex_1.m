% question A
[dates, prices] = load_stock('DIS.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);

zoom_end_916 = find(dates_return==datenum(2008,9,16,16,00,0))/n;
deltax_zoom_916 = deltax(:,zoom_end_916); 

kn = 11;

c_hat_916 = local_variance(deltax_zoom_916,1,n,kn);

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:,1),c_hat_916)
datetick('x','HH:MM');
title('The local variance of September 16, 2008 of DIS');
box off; grid on;
xlabel('time');
ylabel('local variance');
print(f,'-dpng','-r200','figures/1A1');
close(f);

% question B
c_hat = local_variance(deltax,T,n,kn);
average_c_hat = sum(c_hat,2)/T;

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:,1),average_c_hat)
datetick('x','HH:MM');
title('The average local variance across time for each interval of DIS');
box off; grid on;
xlabel('time');
ylabel('average local variance');
print(f,'-dpng','-r200','figures/1B1');
close(f);

