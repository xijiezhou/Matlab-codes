% question A
[dates, prices] = load_stock2('BAC-2015.csv');
kn = 60;
rv_s = realized_var_s(kn,prices);

% question B
average_rv_s = zeros(1,120);
for i =1:1:120
    rv_s=realized_var_s(i,prices);
    average_rv_s(i) = mean(rv_s);
end
frequency=1:120;

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(frequency/12,100*252*average_rv_s)
title('volatility signature plot');
box off; grid on;
xlabel('sample frequency/minute');
ylabel('volatility%');
print(f,'-dpng','-r200','figures/1B');
close(f);

% question C
deltax_y = diff(prices);
rv_y = realized_var(deltax_y);
[n,T] = size(deltax_y);
sigma_chi_2 = rv_y/(2*n);

% question D
% question E
contribution_kn = zeros(1,120);
average_contribution_kn = zeros(1,120);
for i = 1:1:120
contribution_kn = (2*(n/i)*sigma_chi_2)./rv_y;
average_contribution_kn(i) = 100*mean(contribution_kn);
end

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(frequency/12,average_contribution_kn)
title('The average contribution against the frequency plot');
box off; grid on;
xlabel('sample frequency/minute');
ylabel('average contribution%');
print(f,'-dpng','-r200','figures/1E');
close(f);

% question F
rv_subave = realized_var_sub(kn,prices);

f = figure(3);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates,100*252*rv_s)
hold on
plot(dates,100*252*rv_subave)
hold off
datetick('x','mm')
xlabel('month')
ylabel('Realized Variance%')
title('RV_subave and usual RV based on 5-minute Data');
legend('usual RV','RV_subave')
box off; grid on;
print(f,'-dpng','-r200','figures/1F');
close(f);

% question G
tsrv = rv_subave - 2*n/60*sigma_chi_2;

f = figure(4);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates,100*252*rv_s)
hold on
plot(dates,100*252*tsrv)
hold off
datetick('x','mm')
xlabel('month')
ylabel('Realized Variance%')
title('TSRV and usual RV based on 5-minute Data');
legend('usual RV','TSRV')
box off; grid on;
print(f,'-dpng','-r200','figures/1G');
close(f);

% question H
tsrv_s = zeros(120,T);
for kn = 1:120
    rv_subave = realized_var_sub(kn,prices);
    tsrv_s(kn,:) = rv_subave - 2*n/kn*sigma_chi_2;
end

average_tsrv = mean(tsrv_s,2);

f = figure(5);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(frequency/12,100*252*average_rv_s)
hold on
plot(frequency(2:end)/12,100*252*average_tsrv(2:end))
hold off
title('volatility signature plot');
box off; grid on;
xlabel('sample frequency/minute');
ylabel('volatility%');
legend('usual RV','TSRV')
print(f,'-dpng','-r200','figures/1H');
close(f);
