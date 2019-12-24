function [dates, prices] = load_stock(filename)
%load_stock loads rectangular stock data and returns
%serial dates and prices.
%
%Input:
%   filename(string):Name of .csv file with stock data
%   with N proices per day and T total days

%Output:
%   dates(matrix):NxT matrix of special dates
%   prices(matrix):NxT matrix of price
    spy = readmatrix(filename);

    N = sum(spy(1,1) == spy(:,1));
    T = size(spy,1)/N;

    yyyy = floor(spy(:,1)./10^4);
    mm = floor((spy(:,1) - yyyy.*10^4)/10^2);
    dd = spy(:,1) - yyyy.*10^4 - mm.*10^2;

    HH = floor(spy(:,2)./10^2);
    MM = spy(:,2) - HH.*10^2;

    dates = datenum(yyyy,mm,dd,HH,MM,0);
    dates = reshape(dates,N,T);
    prices = log(reshape(spy(:,3),N,T));

end