function [dates, prices] = load_stock2(filename)
    spy = readmatrix(filename);

    N = sum(spy(1,1) == spy(:,1));
    T = size(spy,1)/N;

    yyyy = floor(spy(:,1)./10^4);
    mm = floor((spy(:,1) - yyyy.*10^4)/10^2);
    dd = spy(:,1) - yyyy.*10^4 - mm.*10^2;

    HH = floor(spy(:,2)./10^4);
    MM = floor((spy(:,2)-HH.*10^4)./10^2);
    SS = spy(:,2) - HH.*10^4 - MM.*10^2;

    dates = datenum(yyyy,mm,dd,HH,MM,SS);
    dates = reshape(dates,N,T);
    prices = log(reshape(spy(:,3),N,T));
end