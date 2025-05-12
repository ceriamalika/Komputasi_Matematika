% Fungsi yang ingin diintegralkan
f = @(x) 2*x.^3;

% Batas integrasi
a = 0;
b = 1;

% Banyaknya subinterval
n = 10;

% Panjang langkah
h = (b - a)/n;

% Titik-titik x
x = a:h:b;
fx = f(x);

% Hitung dengan aturan trapesium
Trapes = h/2 * (fx(1) + 2*sum(fx(2:end-1)) + fx(end));

% Tampilkan hasil
fprintf('Luas menggunakan aturan trapesium: %.5f\n', Trapes);
