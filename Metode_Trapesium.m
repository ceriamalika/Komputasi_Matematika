% Fungsi yang ingin diintegralkan
f = @(x) 2*x.^3;

% Batas integrasi
a = 0;
b = 1;
n = 10;
h = (b - a)/n;

x = a:h:b;
fx = f(x);

% Hitung dengan aturan trapesium
Trapes = h/2 * (fx(1) + 2*sum(fx(2:end-1)) + fx(end));

% Tampilkan hasil
fprintf('Luas menggunakan aturan trapesium: %.5f\n', Trapes);
