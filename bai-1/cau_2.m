clear;
close all;

A = [1 2 4 5 3 9 4 2];
a = [4 5 0 2 0 0 7 1];

% a. Tìm B = [A, a]
% giải thích: nối hai vector A và a theo chiều ngang
B = [A, a];
fprintf("B = \n"); disp(B); % 1     2     4     5     3     9     4     2     4     5     0     2     0     0     7     1

% b. Tìm C = [a, A]
% giải thích: nối hai vector a và A theo chiều ngang
C = [a, A];
fprintf("C = \n"); disp(C); % 4     5     0     2     0     0     7     1     1     2     4     5     3     9     4     2

% c. Tìm D = B(2:4)
% giải thích: lấy các phần tử từ vị trí 2 đến vị trí 4 của vector B
D = B(2:4);
fprintf("D = \n"); disp(D); % 2     4     5

% d. Tìm E = [a; A]
% giải thích: nối hai vector a và A theo chiều dọc
E = [a; A];
fprintf("E = \n"); disp(E); % 4     5     0     2     0     0     7     1
                            % 1     2     4     5     3     9     4     2

% e. Tìm F là ma trận con bất kỳ của E có kích thước 2x3
% giải thích: lấy ma trận con từ hàng 1 đến hàng 2 và cột 3 đến cột 5 của ma trận E
F = E(1:2, 3:5);
fprintf("F = \n"); disp(F); % 4     5     0     2     0     0     7     1
                            % 1     2     4     5     3     9     4     2

% f. Tìm G là các vector có thành phần chuyển vị của A
% giải thích: chuyển vị vector A từ hàng sang cột
G = A';
fprintf("G = \n"); disp(G); % 1
                            % 2
                            % 4
                            % 5
                            % 3
                            % 9
                            % 4
                            % 2

% g. Tìm H là tích của các thành phần là tích của các thành phần tương ứng của A và a
% giải thích: nhân các phần tử tương ứng của hai vector A và a
H = A .* a;
fprintf("H = \n"); disp(H); % 4    10     0    10     0     0    28     2

% h. Nhập vector I có các thành phần sau: [2^1 2^2 2^4 2^5 2^3 2^9 2^4 2^2]
% giải thích: tạo vector I với các phần tử là lũy thừa của 2
I = [2^1, 2^2, 2^4, 2^5, 2^3, 2^9, 2^4, 2^2];
fprintf("I = \n"); disp(I); % 2     4    16    32     8   512    16    4