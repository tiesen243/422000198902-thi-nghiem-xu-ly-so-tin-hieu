function [x, ny] = conv_m(x, nx, h, nh)
%conv_m - Description
%
% Syntax: [x, ny] = conv_m(x, nx, h, nh)
%
% Long description
    nyb = nx(1) + nh(1);
    nye = nx(length(x)) + nh(length(h));
    ny = [nyb:nye];
    y = conv(x, h);
end