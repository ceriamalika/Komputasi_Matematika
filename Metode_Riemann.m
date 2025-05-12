% Fungsi yang ingin diintegralkan
f = @(x) 2*x.^3;

% Batas integrasi
a = 0;
b = 1;
n = 10;
h = (b - a)/n;

% Titik tengah tiap subinterval
x = a + h/2 : h : b - h/2;  
fx = f(x);

% Hitung luas dengan jumlah Riemann kiri
Riemann = h * sum(fx);

% Tampilkan hasil
fprintf('Luas menggunakan Riemann tengah: %.5f\n', Riemann);