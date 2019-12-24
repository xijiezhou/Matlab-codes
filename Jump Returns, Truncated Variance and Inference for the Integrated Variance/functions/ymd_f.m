function [yyyy,mm,dd]= ymd_f(filename)
spy = readmatrix(filename);

N = sum(spy(1,1) == spy(:,1));
T = size(spy,1)/N;
day = reshape(spy(:,1),N,T);
yyyy = floor(day(1,:)./10^4);
mm = floor((day(1,:) - yyyy.*10^4)./10^2);
dd = day(1,:) - yyyy.*10^4 - mm.*10^2;
end