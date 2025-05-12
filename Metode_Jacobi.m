% Sistem persamaan linear Ax = b
A = [10 -1  2  0;
    -1 11 -1  3;
     2 -1 10 -1;
     3  0 -1  8];
b = [6; 25; -11; 15];

% Inisialisasi
x = zeros(4,1); % x^(0)
n = length(b);
max_iter = 4; % Lakukan tepat 4 iterasi

fprintf('Jacobi Method (4 Iterasi):\n');
fprintf('Iterasi 0: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', x(1), x(2), x(3), x(4));

% Iterasi Jacobi
for k = 1:max_iter
    x_new = zeros(n,1);
    x_new(1) = (1/10)*(6 + x(2) - 2*x(3));
    x_new(2) = (1/11)*(25 + x(1) + x(3) - 3*x(4));
    x_new(3) = (1/10)*(-11 - 2*x(1) + x(2) + x(4));
    x_new(4) = (1/8)*(15 - 3*x(2) + x(3));
    
    % Tampilkan hasil iterasi
    fprintf('Iterasi %d: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', ...
            k, x_new(1), x_new(2), x_new(3), x_new(4));

    % Update nilai x untuk iterasi berikutnya
    x = x_new;
end

disp('Hasil akhir setelah 4 iterasi Jacobi:');
disp(x);