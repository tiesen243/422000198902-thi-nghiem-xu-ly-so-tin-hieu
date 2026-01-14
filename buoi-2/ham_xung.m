function [x, n] = ham_xung(n0, n1, n2)
    % ham_xung - Description
    %
    % Syntax: [x,n] = ham_xung(n0,n1,n2)
    %
    % Long description
    n = [n1:n2];
    x = [(n - n0) == 0];
end

