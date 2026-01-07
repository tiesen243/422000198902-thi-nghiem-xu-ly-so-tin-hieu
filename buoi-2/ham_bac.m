function [x,n] = ham_bac(n0, n1, n2)
%ham_bac - Description
%
% Syntax: [x,n] = ham_bac(n0,n1,n2)
%
% Long description
    n = [n1:n2];
    x = [(n - n0) >= 0];
end