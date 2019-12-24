function [dates_return, deltax] = log_returns(dates, prices)

deltax = diff(prices);%return

dates_return = dates(2:end,:);

end