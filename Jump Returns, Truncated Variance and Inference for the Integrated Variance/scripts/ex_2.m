%compute the truncated variance
[dates, prices] = load_stock('DIS.csv');

% question A
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;

tau = tau_f(deltax);
BV = bipower_var(deltax);
alpha = 4;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;

TV = sum((rc).^2);

f = figure(11);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(1,:),100*sqrt(TV*252))
datetick('x','YYYY');
title('the truncated variance of DIS');
box off; grid on;
xlabel('time');
ylabel('truncated variance');
print(f,'-dpng','-r200','figures/2A1');
close(f);

RV1 = realized_var(deltax);

RV_last1 = 100*sqrt(RV1*252);

dates_RV_last1 = dates_return(1,:);

f = figure(12);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(1,:),100*sqrt(TV*252))
hold on
plot(dates_RV_last1,RV_last1)
p2.Color(4) = 0.25;
hold off
legend('TV','RV')
datetick('x','YYYY');
title('the truncated variance and the realized variance of DIS');
box off; grid on;
xlabel('time');
ylabel('truncated variance and the realized variance');
print(f,'-dpng','-r200','figures/2B1');
close(f);

%create QIV
QIV = 1/(3*deltan)*sum((rc).^4);

f = figure(13);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(1,:),100*sqrt(QIV*252))
datetick('x','YYYY');
title('the quartic integrated variance of DIS');
box off; grid on;
xlabel('time');
ylabel('quartic integrated variance');
print(f,'-dpng','-r200','figures/2C1');
close(f);

% CI95 = norminv([0.025 0.975]);
% TVCI95 = TV + CI95(:).*sqrt(2/n*QIV) ;
% questian D
CI_TV = ci_f(0.05,n,TV,QIV);


f = figure(14);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates(1,:),CI_TV(1:2,:));
hold on
plot(dates(1,:),TV);
hold off
datetick('x','yyyy');
legend('CI_IV','TV');
title('confidence interval of truncated variance of DIS');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2D1');
close(f);

% question E
zoom_start = find(dates_return==datenum(2008,10,1,16,0,0))/n;
zoom_end = find(dates_return==datenum(2008,10,31,16,0,0))/n;
TV_zoom = TV(zoom_start:zoom_end); 
CI_zoom = CI_TV(:,zoom_start:zoom_end);
dates_zoom = dates_return(1,zoom_start:zoom_end);

f = figure(15);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom,TV_zoom)
hold on
plot(dates_zoom,CI_zoom)
hold off
datetick('x','dd');
legend('TV_zoom','CI_zoom');
title('confidence interval of truncated variance on 2018 Oct. of DIS');
box off; grid on;
xlabel('time');
ylabel('CI on 2018 Oct.');
print(f,'-dpng','-r200','figures/2E1');
close(f);

% question h

% a_CI_TV_zoom = 100*sqrt(CI_TV_zoom*252);
zoom_start_2 = find(dates_return==datenum(2008,10,1,16,0,0))/n;
zoom_end_2 = find(dates_return==datenum(2008,12,31,16,0,0))/n;
TV_zoom_2 = TV(zoom_start_2:zoom_end_2); 
CI_zoom_2 = CI_TV(:,zoom_start_2:zoom_end_2);
dates_zoom_2 = dates_return(1,zoom_start_2:zoom_end_2);
a_CI_zoom_2 = 100*sqrt(CI_zoom_2*252);
a_TV_zoom_2 = 100*sqrt(TV_zoom_2*252);

f = figure(16);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_zoom_2,a_CI_zoom_2);
hold on
plot(dates_zoom_2,a_TV_zoom_2);
hold off
datetick('x','dd');
legend('a_CI_zoom_2','a_TV_zoom_2');
title('confidence interval of annualized truncated variance of DIS');
box off; grid on;
xlabel('time');
ylabel('CI');
print(f,'-dpng','-r200','figures/2H1');
close(f);

