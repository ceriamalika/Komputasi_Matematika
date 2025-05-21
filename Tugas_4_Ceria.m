% Bentuk 1: Bola(Sphere)
figure;
[x, y, z] = sphere(50);
surf(x, y, z)
title('Bentuk 1: Bola')
axis equal
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 2: Paraboloid
figure;
[x, y] = meshgrid(-2:0.1:2, -2:0.1:2);
z = x.^2 + y.^2;
surf(x, y, z)
title('Bentuk 2: Paraboloid')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 3: Saddle Surface (Permukaan Pelana)
figure;
[x, y] = meshgrid(-2:0.1:2, -2:0.1:2);
z = x.^2 - y.^2;
surf(x, y, z)
title('Bentuk 3: Permukaan Pelana')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 4: Gelombang Sinus 3D
figure;
[x, y] = meshgrid(-4:0.1:4, -4:0.1:4);
z = sin(sqrt(x.^2 + y.^2));
surf(x, y, z)
title('Bentuk 4: Gelombang Sinus')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 5: Kerucut (Cone)
figure;
[x, y] = meshgrid(-2:0.1:2, -2:0.1:2);
z = sqrt(x.^2 + y.^2);
surf(x, y, z)
title('Bentuk 5: Kerucut')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 6: Torus (Donat)
figure;
theta = linspace(0, 2*pi, 50);
phi = linspace(0, 2*pi, 50);
[theta, phi] = meshgrid(theta, phi);
R = 2; r = 0.5;
x = (R + r.*cos(phi)) .* cos(theta);
y = (R + r.*cos(phi)) .* sin(theta);
z = r .* sin(phi);
surf(x, y, z)
title('Bentuk 6: Torus')
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal

% Bentuk 7: Permukaan Sin-Cos
figure;
[x, y] = meshgrid(-5:0.25:5, -5:0.25:5);
z = sin(x) .* cos(y);
surf(x, y, z)
title('Bentuk 7: Permukaan Sin-Cos')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 8: Permukaan Gaussian
figure;
[x, y] = meshgrid(-3:0.1:3, -3:0.1:3);
z = exp(-x.^2 - y.^2);
surf(x, y, z)
title('Bentuk 8: Gaussian')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 9: Heliks 3D
figure;
t = linspace(0, 10*pi, 1000);
x = cos(t);
y = sin(t);
z = t;
plot3(x, y, z)
title('Bentuk 9: Heliks')
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on

% Bentuk 10: Permukaan Cosinus Bergelombang 
figure;
[x, y] = meshgrid(-4:0.1:4, -4:0.1:4);
z = cos(x) + cos(y);
surf(x, y, z)
title('Bentuk 10: Cosinus Bergelombang')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 11: Piramida
figure;
[x, y] = meshgrid(-1:0.05:1, -1:0.05:1);
z = 1 - max(abs(x), abs(y));
z(z < 0) = NaN; % Hindari area negatif
surf(x, y, z)
title('Bentuk 11: Piramida')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 12: Spiral Shell (Kerang Laut Parametrik)
figure;
theta = linspace(0, 4*pi, 200);
phi = linspace(0, 2*pi, 50);
[theta, phi] = meshgrid(theta, phi);
a = 0.2;
b = 0.6;
c = 0.1;
x = (a + b.*theta.*cos(phi)) .* cos(theta);
y = (a + b.*theta.*cos(phi)) .* sin(theta);
z = c*theta + b.*theta.*sin(phi);
surf(x, y, z)
title('Bentuk 12: Spiral Shell')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 13: Permukaan Saddle Tingkat Lanjut (Monkey Saddle)
figure;
[x, y] = meshgrid(-2:0.05:2, -2:0.05:2);
z = x.^3 - 3*x.*y.^2;
surf(x, y, z)
title('Bentuk 13: Monkey Saddle')
xlabel('X'); ylabel('Y'); zlabel('Z');

% Bentuk 14: Love
% volume data
step = 0.05;
[X,Y,Z] = meshgrid(-3:step:3, -3:step:3, -3:step:3);
F = (-(X.^2).*(Z.^3)-(9/80).*(Y.^2).*(Z.^3))+((X.^2)+(9/4).*(Y.^2)+(Z.^2)-1).^3;
% shaded surface
isosurface(X,Y,Z,F,0)
lighting phong
axis equal
view(-39,30)
set(gcf, 'Color','w')
colormap flag
title('Bentuk 14: Hati')

% Bentuk 15: Spiral Heliks Bergelombang
figure;
t = linspace(0, 6*pi, 200);
z = linspace(0, 5, 200);
r = 1 + 0.5 * sin(5*t);  % variasi jari-jari
x = r .* cos(t);
y = r .* sin(t);
plot3(x, y, z, 'LineWidth', 2)
grid on
title('Bentuk 15: Spiral Heliks Bergelombang')
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal

% Bentuk 16: Bintang Laut
clc; clear; close all;
% Parameter grid
theta = linspace(0, 2*pi, 200);   % Sudut polar
r = linspace(0, 1, 100);          % Jari-jari
[theta, r] = meshgrid(theta, r);
% Bentuk bintang laut dengan 5 lengan
arms = 5;
rho = r .* (1 + 0.3 * sin(arms * theta));  
% Konversi ke koordinat Cartesian
x = rho .* cos(theta);
y = rho .* sin(theta);
% Bentuk permukaan 3D melengkung
z = 0.2 * (1 - r.^2) .* cos(arms * theta);
% Plot permukaan
figure;
surf(x, y, z, z, 'EdgeColor', 'none');
colormap(jet); 
shading interp
% Tampilan dan pencahayaan
axis equal
view(3);
xlabel('X'); ylabel('Y'); zlabel('Z');
camlight headlight
lighting phong
% Judul dan properti teks
title('Bentuk 16: Bintang Laut', 'FontSize', 14, 'FontWeight', 'bold');
