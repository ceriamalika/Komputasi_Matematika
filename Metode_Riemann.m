% Fungsi yang ingin diintegralkan
f = @(x) 2*x.^3;

% Batas integrasi
a = 0;
b = 1;
n = 10;
h = (b - a)/n;

% Metode Riemann Kiri
x_kiri = a : h : b - h;
fx_kiri = f(x_kiri);
RiemannKiri = h * sum(fx_kiri);

% Metode Riemann Kanan
x_kanan = a + h : h : b;
fx_kanan = f(x_kanan);
RiemannKanan = h * sum(fx_kanan);

% Metode Riemann Tengah
x_tengah = a + h/2 : h : b - h/2;
fx_tengah = f(x_tengah);
RiemannTengah = h * sum(fx_tengah);

% Tampilkan hasil
fprintf('Luas menggunakan Riemann kiri   : %.5f\n', RiemannKiri);
fprintf('Luas menggunakan Riemann kanan  : %.5f\n', RiemannKanan);
fprintf('Luas menggunakan Riemann tengah : %.5f\n', RiemannTengah);