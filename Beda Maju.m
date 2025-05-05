%Fungsi f(x) = 2x
f = @(x) 2*x;
%Titik evaluasi
x = 1;
% Daftar nilai h
% h_values = 0.01;
% h_values = [1e-1, 1e-2, 1e-3, 1e-4];
%Turunan eksak
df_exact = 2;
disp("---Perbandingan Turunan Numerik untuk f(x) = 2x ---")
% Loop untuk tiap nilai h
% for i = 1:5
for i = 1:5
    %h = h values(i);