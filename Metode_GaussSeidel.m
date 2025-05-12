% Sistem persamaan linear Ax = b
A = [10 -1  2  0;
    -1 11 -1  3;
     2 -1 10 -1;
     3  0 -1  8];
b = [6; 25; -11; 15];

% Inisialisasi
x = zeros(4,1); % x^(0)
n = length(b);
max_iter = 4;

fprintf('Gauss-Seidel Method (4 Iterasi):\n');
fprintf('Iterasi 0: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', x(1), x(2), x(3), x(4));

% Iterasi Gauss-Seidel
for k = 1:max_iter
    x_old = x;
    
    x(1) = (1/10)*(6 + x_old(2) - 2*x_old(3));       % Gunakan x(k-1) untuk x2 dan x3
    x(2) = (1/11)*(25 + x(1) + x_old(3) - 3*x_old(4));
    x(3) = (1/10)*(-11 - 2*x(1) + x(2) + x_old(4));   % x1 dan x2 sudah diupdate
    x(4) = (1/8)*(15 - 3*x(2) + x(3));                % x2 dan x3 baru

    % Tampilkan hasil iterasi
    fprintf('Iterasi %d: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', ...
            k, x(1), x(2), x(3), x(4));
end

disp('Hasil akhir setelah 4 iterasi Gauss-Seidel:');
disp(x);