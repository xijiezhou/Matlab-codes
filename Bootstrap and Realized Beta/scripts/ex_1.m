[dates, prices] = load_stock('DIS.csv');
% question A
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;
tau = tau_f(deltax);

BV = bipower_var(deltax);
alpha = 4.5;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rd = deltax;
rd(abs(deltax)<=cutoff)=0;

jumps = sum(rd~=0);
y = zeros(12,1);
[yyyy,mm,dd]= ymd_f('DIS.csv');
for i = 1:11
    y(i+1) = sum(ismember(yyyy,2006+i));
end
jumps_y = zeros(11,1);
for i = 1:11
    jumps_y(i) = sum(jumps(1,(sum(y(1:i))+1):sum(y(1:i+1))));
end

% question B
rc = deltax;
rc(abs(deltax)>cutoff)=0;

TV = sum((rc).^2);

% question C
returns = deltax;
kn = 7;
M = 11;

J = 10000;
statistics = zeros(J,T);
parfor j = 1:J
    new_returns = bootstrap_stock(returns,n,T,kn,M);
    statistics(j,:) = sum(new_returns.^2);
end

% ci of statistics
CI_statistics = ci_f(0.05,mean(statistics),std(statistics));

zoom_start = find(dates_return==datenum(2008,10,6,16,0,0))/n;
zoom_end = find(dates_return==datenum(2008,10,17,16,0,0))/n;
TV_zoom = TV(zoom_start:zoom_end); 
CI_zoom = CI_statistics(:,zoom_start:zoom_end);
dates_zoom = dates_return(1,zoom_start:zoom_end);

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom,TV_zoom)
hold on
plot(dates_zoom,CI_zoom)
hold off
datetick('x','mmdd');
legend('TV_zoom','CI_zoom');
title('confidence interval of truncated variance in two weeks of DIS');
box off; grid on;
xlabel('time');
ylabel('CI in two weeks');
print(f,'-dpng','-r200','figures/1C1');
close(f);

% question E
CI_statistics_a = ci_f(0.05,mean(100*sqrt(statistics*252)),std(100*sqrt(statistics*252)));
TV_a =100*sqrt(TV*252);

zoom_start = find(dates_return==datenum(2008,10,6,16,0,0))/n;
zoom_end = find(dates_return==datenum(2008,10,17,16,0,0))/n;
TV_zoom_a = TV_a(zoom_start:zoom_end); 
CI_zoom_a = CI_statistics_a(:,zoom_start:zoom_end);
dates_zoom_a = dates_return(1,zoom_start:zoom_end);

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom_a,TV_zoom_a)
hold on
plot(dates_zoom_a,CI_zoom_a)
hold off
datetick('x','mmdd');
legend('TV_zoom','CI_zoom');
title('confidence interval of annualized truncated variance in two weeks of DIS');
box off; grid on;
xlabel('time');
ylabel('CI in two weeks');
print(f,'-dpng','-r200','figures/1E1');
close(f);



