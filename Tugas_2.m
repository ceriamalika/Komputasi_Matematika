% Nested if
cuaca = input('Masukkan cuaca (1 = dingin, 2 = panas): ');
waktu = input('Masukkan waktu (1 = pagi, 2 = malam): ');

if cuaca == 1  % dingin
    if waktu == 1  % pagi
        disp('Minum kopi hitam hangat.');
    elseif waktu == 2  % malam
        disp('Minum cafe latte.');
    else
        disp('Waktu tidak diketahui.');
    end
elseif cuaca == 2  % panas
    disp('Minum kopi susu dingin');
else
    disp('Minum affogato.');
end

% While
x = 1;

while x <= 5
    disp(x);
    x = x + 1;
end