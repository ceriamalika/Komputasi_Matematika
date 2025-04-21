% metode bagi dua
function [x, galat] = bagidua_1(f, X, N, tol)
% inputan
% f = fungsi
% X = interval [a,b] dimana a<b
% N = maksimum iterasi
% tol = 1e-3

% output
% x = akar
% galat = error
if nargin < 4, tol = 1e-3;end %nargin adalah buat kondisi disamaan 1 baris
if nargin < 3, N = 100 ;end 

a = X(1);
b = X(2);
x = (a + b)/2;
n = 1
galat = 1;

while (n <= N && galat > tol)
    if f(a)*f(x)< 0
        b = x
    elseif f(a)*f(x) > 0 
        a = x ;
    else
        break;
    end
    xnew = (a + b)/2;
    galat = abs((xnew - x)/xnew)*100;
    x = xnew; %(x belum merupakan akarnya maka iterasi diulangi lagi)
    n = n + 1;
end
end
