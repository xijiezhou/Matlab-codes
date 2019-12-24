[dates, prices] = load_stock('DIS.csv');

[dates_return,deltax] = log_returns(dates, prices);

RV1 = realized_var(deltax);

RV_last1 = 100*sqrt(RV1*252);

dates_RV_last1 = dates_return(1,:);%Extract the first line of the matrix


f = figure(5);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_RV_last1,RV_last1)
datetick('x','yyyy');
title('realized variance of DIS');
box off; grid on;
xlabel('time/year');
ylabel('realized variance');
print(f,'-dpng','-r200','figures/2A1');
close(f);

BV1 = bipower_var(deltax);
BV_last1 = 100*sqrt(BV1*252);
dates_BV_last1 = dates_RV_last1;

f = figure(6);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_BV_last1,BV_last1)
datetick('x','yyyy');
title('bipower variance of DIS');
box off; grid on;
xlabel('time/year');
ylabel('bipower variance');
print(f,'-dpng','-r200','figures/2B1');
close(f);

f = figure(7);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_RV_last1,RV_last1);
hold on
p2 = plot(dates_BV_last1,BV_last1);
p2.Color(4) = 0.25;
hold off
datetick('x','yyyy');
title('realized variance and bipower variance of DIS');
box off; grid on;
xlabel('time/year');
ylabel('realized variance and bipower variance');
print(f,'-dpng','-r200','figures/2C1');
close(f);

[n,T] = size(dates_BV_last1);
C1 = zeros(n,T);
for t = 1:T
    C1(t) = (max(RV_last1(t)-BV_last1(t),0))./RV_last1(t);
end

Ca1 = 100*mean(C1);



[dates, prices] = load_stock('PG.csv');

[dates_return,deltax] = log_returns(dates, prices);

RV2 = realized_var(deltax);

RV_last2 = 100*sqrt(RV2*252);

dates_RV_last2 = dates_return(1,:);%Extract the first line of the matrix"dats"

f = figure(8);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_RV_last2,RV_last2)
datetick('x','yyyy');
title('realized variance of PG');
box off; grid on;
xlabel('time/year');
ylabel('realized variance');
print(f,'-dpng','-r200','figures/2A2');
close(f);

BV2 = bipower_var(deltax);
BV_last2 = 100*sqrt(BV2*252);
dates_BV_last2 = dates_RV_last2;

f = figure(9);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_BV_last2,BV_last2)
datetick('x','yyyy');
title('bipower variance of PG');
box off; grid on;
xlabel('time/year');
ylabel('bipower variance');
print(f,'-dpng','-r200','figures/2B2');
close(f);

f = figure(10);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_RV_last2,RV_last2);
hold on
p2 = plot(dates_BV_last2,BV_last2);
p2.Color(4) = 0.25;
hold off
datetick('x','yyyy');
title('realized variance and bipower variance of PG');
box off; grid on;
xlabel('time/year');
ylabel('realized variance and bipower variance');
print(f,'-dpng','-r200','figures/2C2');
close(f);

[n,T] = size(dates_BV_last2);
C2 = zeros(n,T);
for t = 1:T
    C2(t) = (max(RV_last2(t)-BV_last2(t),0))./RV_last2(t);
end

Ca2 = 100*mean(C2);
