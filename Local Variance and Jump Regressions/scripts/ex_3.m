% question A
[dates_m, prices_m] = load_stock('SPY.csv');
[dates_return_m,deltax_m] = log_returns(dates_m, prices_m);
[n,T] = size(deltax_m);
deltan = 1/n;

tau_m = tau_f(deltax_m);
BV_m = bipower_var(deltax_m);
alpha = 5;
cutoff_m = alpha*deltan^0.49*sqrt(tau_m*BV_m);

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

rd_m_y = sum(rd_m);
mag_rd_y = zeros(11,1);
for i = 1:11
    mag_rd_y(i) = sum(abs(rd_m_y(1,(sum(y(1:i))+1):sum(y(1:i+1)))));
end
av_mag_rd_y = mag_rd_y./jumps_y;

% question B
[dates_1, prices_1] = load_stock('DIS.csv');
[dates_return_1,deltax_1] = log_returns(dates_1, prices_1);

j_m = (rd_m ~=0);
rd_j_1 = j_m .* deltax_1;

f = figure(7);
set(f,'units','normalized','outerposition',[0 0 1 1]);
scatter(rd_m(:)*100,rd_j_1(:)*100)
title('DIS returns against market jump returns at jump times');
box off; grid on;
xlabel('market jump returns%');
ylabel('stock returns%');
print(f,'-dpng','-r200','figures/3B1');
close(f);

[dates_2, prices_2] = load_stock('PG.csv');
[dates_return_2,deltax_2] = log_returns(dates_2, prices_2);

rd_j_2 = j_m .* deltax_2;

f = figure(8);
set(f,'units','normalized','outerposition',[0 0 1 1]);
scatter(rd_m(:)*100,rd_j_2(:)*100)
title('PG returns against market jump returns at jump times');
box off; grid on;
xlabel('market jump returns%');
ylabel('stock returns%');
print(f,'-dpng','-r200','figures/3B2');
close(f);

% queation C
betaj_1 = jump_beta(rd_m,deltax_1);

betaj_2 = jump_beta(rd_m,deltax_2);

% question D
x = rd_m(:) * 100 * 1.3;

f = figure(9);
set(f,'units','normalized','outerposition',[0 0 1 1]);
scatter(x,rd_j_1(:)*100);
hold on
plot(x,rd_m(:)*100 * betaj_1);
hold off
title('DIS returns against market jump returns at jump times')
box off; grid on;
xlabel('market jump returns%')
ylabel('stock returns%')
legend('stock returns','regression line')
print(f,'-dpng','-r200','figures/3D1');
close(f);

f = figure(10);
set(f,'units','normalized','outerposition',[0 0 1 1]);
scatter(x,rd_j_2(:)*100);
hold on
plot(x,rd_m(:)*100 * betaj_2);
hold off
title('PG returns against market jump returns at jump times')
box off; grid on;
xlabel('market jump returns%')
ylabel('stock returns%')
legend('stock returns','regression line')
print(f,'-dpng','-r200','figures/3D2');
close(f);

% question E
V_beta_hat_1 = V_beta(deltax_1,betaj_1,deltax_m,rd_m,n,T);
std_1 = sqrt(deltan*V_beta_hat_1);

V_beta_hat_2 = V_beta(deltax_2,betaj_2,deltax_m,rd_m,n,T);
std_2 = sqrt(deltan*V_beta_hat_2);

% question F
ci_betaj_1 = ci_f(0.05,betaj_1,std_1);

ci_betaj_2 = ci_f(0.05,betaj_2,std_2);

% question G
hedge_1 = 200 * betaj_1;
hedge_2 = 200 * betaj_2;
hedge_1_r = 200 * ci_betaj_1;
hedge_2_r = 200 * ci_betaj_2;

% question H
zoom_start_11 = find(dates_return_1==datenum(2007,1,3,16,0,0))/n;
zoom_end_11 = find(dates_return_1==datenum(2011,12,30,16,0,0))/n;
rd_m_1 = rd_m(:,zoom_start_11:zoom_end_11);
deltax_1_1 = deltax_1(:,zoom_start_11:zoom_end_11);
deltax_m_1 = deltax_m(:,zoom_start_11:zoom_end_11);

zoom_start_12= find(dates_return_1==datenum(2012,1,3,16,0,0))/n;
zoom_end_12 = find(dates_return_1==datenum(2017,12,29,16,0,0))/n;
rd_m_2 = rd_m(:,zoom_start_12:zoom_end_12);
deltax_1_2 = deltax_1(:,zoom_start_12:zoom_end_12);
deltax_m_2 = deltax_m(:,zoom_start_12:zoom_end_12);

betaj_1_1 = jump_beta(rd_m_1,deltax_1_1);
betaj_1_2 = jump_beta(rd_m_2,deltax_1_2);
V_beta_hat_1_1 = V_beta(deltax_1_1,betaj_1_1,deltax_m_1,rd_m_1,n,1260);
V_beta_hat_1_2 = V_beta(deltax_1_2,betaj_1_2,deltax_m_2,rd_m_2,n,1509);

zoom_start_21 = find(dates_return_2==datenum(2007,1,3,16,0,0))/n;
zoom_end_21 = find(dates_return_2==datenum(2011,12,30,16,0,0))/n;
rd_m_1 = rd_m(:,zoom_start_21:zoom_end_21);
deltax_2_1 = deltax_2(:,zoom_start_21:zoom_end_21);
deltax_m_1 = deltax_m(:,zoom_start_21:zoom_end_21);

zoom_start_22 = find(dates_return_2==datenum(2012,1,3,16,0,0))/n;
zoom_end_22 = find(dates_return_2==datenum(2017,12,29,16,0,0))/n;
rd_m_2 = rd_m(:,zoom_start_22:zoom_end_22);
deltax_2_2 = deltax_2(:,zoom_start_22:zoom_end_22);
deltax_m_2 = deltax_m(:,zoom_start_22:zoom_end_22);

betaj_2_1 = jump_beta(rd_m_1,deltax_2_1);
betaj_2_2 = jump_beta(rd_m_2,deltax_2_2);
V_beta_hat_2_1 = V_beta(deltax_2_1,betaj_2_1,deltax_m_1,rd_m_1,n,1260);
V_beta_hat_2_2 = V_beta(deltax_2_2,betaj_2_2,deltax_m_2,rd_m_2,n,1509);

% question I
std_11 = sqrt(deltan*(V_beta_hat_1_1 + V_beta_hat_1_2));
ci_betaj_11 = ci_f(0.05,betaj_1_1-betaj_1_2,std_11);

std_22 = sqrt(deltan*(V_beta_hat_2_1 + V_beta_hat_2_2));
ci_betaj_22 = ci_f(0.05,betaj_2_1-betaj_2_2,std_22);
