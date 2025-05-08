% Latihan membuat grafik
% x = [-10:1:10]
% y = x.^2; %harus pakai . karena gak pakai syms dan ada nilainya
% plot(x, y)

%Grafik 1
% x = linspace(0,2*pi);
% y = sin(x)
% plot(x,y)

%Menambahkan label dan judul
% xlabel('x')
% ylabel('sin(x)')
% title('Plot of the Sine Function')
% 
% %Dengan menambahkan argumen input ketiga ke fungsi plot, dapat memplot variabel yang sama menggunakan garis putus-putus merah.
% plot(x, y, 'r--')
% 
% x = linspace(0,2*pi);
% y = sin(x)
% plot(x, y)
% 
% hold on
% 
% y2 = cos(x)
% 
% plot(x,y2,':')
% legend('sin','cos')
% 
% hold off

% % Equal Maxima
% x = [0:0.001:1]
% y = (sin(5*pi*x)).^6
% plot(x, y, 'ok')

% % Decreasing
% x = [0:0.001:1]
% y = exp(-2*log(2)*((x-0.1)/0.8).^2).*(sin(5*pi*x)).^6;
% plot(x, y, 'om')

% % Second Minima
% x = -4:0.1:4; %sumbu x
% y = -4:0.1:4; %sumbu y
% [X, Y] = meshgrid(x, y);
% f = (0.5*(X.^4-16*X.^2+5*X)  +0.5*(Y.^4-16*Y.^2+5*Y));
% figure(1) % memunculkan beberapa plot
% plot3(X, Y, f)
% figure(2)
% contour(X, Y, f)
% figure(3)
% contour3(X, Y, f)
% figure(4)
% surf(X, Y, f)
% figure(5)
% surfc(X, Y, f)
% figure(6)
% meshc(X, Y, f)

% Six Ham 
x = -1.9:0.1:1.9; 
y = -1.1:0.1:1.1; 
[X, Y] = meshgrid(x, y);
f = (4 - 2.1*X.^2+X.^4/3).*X.^2+X.*Y+4*(-1+Y.^2).*Y.^2;
figure(1) 
plot3(X, Y, f)
figure(2)
contour(X, Y, f)
figure(3)
contour3(X, Y, f)
figure(4)
surf(X, Y, f)
figure(5)
surfc(X, Y, f)
figure(6)
meshc(X, Y, f)
