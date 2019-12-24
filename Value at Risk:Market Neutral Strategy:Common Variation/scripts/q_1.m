% A
[dates, prices] = load_stock('DIS.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);

zoom_end_916 = find(dates_return==datenum(2008,9,16,16,00,0))/n;
dates_zoom_916 = dates_return(:,zoom_end_916);

% B
zoom_end_915 = find(dates_return==datenum(2008,9,15,16,00,0))/n;
dates_zoom_915 = dates_return(:,zoom_end_915);

deltan = 1/n;
deltax_915 = deltax(:,zoom_end_915);
tau_915 = tau_f(deltax_915);
BV_915 = bipower_var(deltax_915);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau_915*BV_915);
rc_915 = deltax_915;
rc_915(abs(deltax_915)>cutoff)=0;

TV_915 = sum((rc_915).^2);

% use the same way on 916

deltax_916 = deltax(:,zoom_end_916);
tau_916 = tau_f(deltax_916);
BV_916 = bipower_var(deltax_916);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau_916*BV_916);
rc_916 = deltax_916;
rc_916(abs(deltax_916)>cutoff)=0;

TV_916 = sum((rc_916).^2);

% C
QIV_915 = 1/(3*deltan)*sum((rc_915).^4);
CI_IV_915 = [TV_915-1.96*sqrt(2*deltan*QIV_915),TV_915+1.96*sqrt(2*deltan*QIV_915)];

pd = makedist('Normal','mu',0,'sigma',1);
p_2 = cdf(pd,-0.02/sqrt(TV_915));
p_4 = cdf(pd,-0.04/sqrt(TV_915));

p2_lower = cdf(pd,-0.02/sqrt(CI_IV_915(1,1)));
p2_upper = cdf(pd,-0.02/sqrt(CI_IV_915(1,2)));
P2_CI = [p2_lower,p2_upper];
P2_width = p2_upper - p2_lower;

p4_lower = cdf(pd,-0.04/sqrt(CI_IV_915(1,1)));
p4_upper = cdf(pd,-0.04/sqrt(CI_IV_915(1,2)));
P4_CI = [p4_lower,p4_upper];
P4_width = p4_upper - p4_lower;

% D
Q_1 = icdf(pd,0.01);
Q_5 = icdf(pd,0.05);

VaR_1 = Q_1*sqrt(TV_915)*200000000;
VaR_1_upper = icdf(pd,0.01)*sqrt(CI_IV_915(1,1))*200000000;
VaR_1_lower = icdf(pd,0.01)*sqrt(CI_IV_915(1,2))*200000000;
VaR_1_CI = [VaR_1_lower,VaR_1_upper];
width_1 = VaR_1_upper - VaR_1_lower;

VaR_5 = Q_5*sqrt(TV_915)*200000000;
VaR_5_upper = icdf(pd,0.05)*sqrt(CI_IV_915(1,1))*200000000;
VaR_5_lower = icdf(pd,0.05)*sqrt(CI_IV_915(1,2))*200000000;
VaR_5_CI = [VaR_5_lower,VaR_5_upper];
width_5 = VaR_5_upper - VaR_5_lower;








