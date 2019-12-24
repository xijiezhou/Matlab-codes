[dates, prices] = load_stock('DIS.csv');

% deltax = diff(prices); %return
% dates_return = dates(2:end,:);

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates(:),prices(:))
datetick('x','yyyy');
title('stock prices of DIS');
box off; grid on;
xlabel('time/year');
ylabel('price');
print(f,'-dpng','-r200','figures/1E1A');
close(f);

[dates_return, deltax] = log_returns(dates, prices);

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*deltax(:))
datetick('x','yyyy');
title('stock returns of DIS');
box off; grid on;
xlabel('time/year');
ylabel('return%');
print(f,'-dpng','-r200','figures/1E1B');
close(f);

[dates, prices] = load_stock('PG.csv');

f = figure(3);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates(:),prices(:))
datetick('x','yyyy');
title('stock prices of PG');
box off; grid on;
xlabel('time/year');
ylabel('price');
print(f,'-dpng','-r200','figures/1E2A');
close(f);

[dates_return, deltax] = log_returns(dates, prices);

f = figure(4);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*deltax(:))
datetick('x','yyyy');
title('stock returns of PG');
box off; grid on;
xlabel('time/year');
ylabel('return%');
print(f,'-dpng','-r200','figures/1E2B');
close(f);
