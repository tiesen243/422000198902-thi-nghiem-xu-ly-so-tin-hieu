function b = fir1(n, Wn, varargin)
%FIR1 Design linear-phase FIR filter using the window method.
%   b = FIR1(n, Wn) designs an order-n lowpass FIR filter.
%   b = FIR1(n, Wn, TYPE) supports TYPE = 'low', 'high', 'bandpass', 'stop'.
%   b = FIR1(n, Wn, TYPE, WINDOW) uses WINDOW of length n+1.
%   b = FIR1(..., 'noscale') disables gain normalization.

narginchk(2, 5);

validateattributes(n, {'numeric'}, {'scalar', 'integer', 'nonnegative', 'finite'}, mfilename, 'n', 1);
validateattributes(Wn, {'numeric'}, {'vector', 'real', 'finite', '>', 0, '<', 1}, mfilename, 'Wn', 2);

type = '';
win = [];
doScale = true;

for k = 1:numel(varargin)
    arg = varargin{k};
    if ischar(arg) || (isstring(arg) && isscalar(arg))
        s = lower(char(arg));
        switch s
            case {'low', 'lowpass', 'high', 'highpass', 'bandpass', 'stop', 'bandstop'}
                type = s;
            case 'noscale'
                doScale = false;
            case 'scale'
                doScale = true;
            otherwise
                error('fir1:InvalidOption', 'Unknown option: %s', s);
        end
    elseif isnumeric(arg)
        win = arg(:).';
    else
        error('fir1:InvalidArgument', 'Unsupported argument type.');
    end
end

if isempty(type)
    if numel(Wn) == 1
        type = 'low';
    elseif numel(Wn) == 2
        type = 'bandpass';
    else
        error('fir1:InvalidCutoff', 'Wn must have 1 or 2 elements.');
    end
end

Wn = Wn(:).';
if numel(Wn) == 2 && Wn(1) >= Wn(2)
    error('fir1:InvalidCutoffOrder', 'For two-element Wn, require Wn(1) < Wn(2).');
end

if isempty(win)
    win = localHamming(n + 1);
end
validateattributes(win, {'numeric'}, {'vector', 'real', 'finite', 'numel', n + 1}, mfilename, 'window');
win = win(:).';

m = n / 2;
idx = 0:n;
x = idx - m;

switch type
    case {'low', 'lowpass'}
        if numel(Wn) ~= 1
            error('fir1:InvalidCutoff', 'Lowpass requires scalar Wn.');
        end
        h = idealLowpass(Wn(1), x);
        scaleFreq = 0;
        
    case {'high', 'highpass'}
        if numel(Wn) ~= 1
            error('fir1:InvalidCutoff', 'Highpass requires scalar Wn.');
        end
        h = -idealLowpass(Wn(1), x);
        h(idx == m) = h(idx == m) + 1;
        scaleFreq = pi;
        
    case 'bandpass'
        if numel(Wn) ~= 2
            error('fir1:InvalidCutoff', 'Bandpass requires two-element Wn.');
        end
        h = idealLowpass(Wn(2), x) - idealLowpass(Wn(1), x);
        scaleFreq = pi * mean(Wn);
        
    case {'stop', 'bandstop'}
        if numel(Wn) ~= 2
            error('fir1:InvalidCutoff', 'Bandstop requires two-element Wn.');
        end
        h = idealLowpass(Wn(1), x) + (deltaAtZero(x) - idealLowpass(Wn(2), x));
        scaleFreq = 0;
        
    otherwise
        error('fir1:InvalidType', 'Unsupported filter type: %s', type);
end

b = h .* win;

if doScale
    g = responseAt(b, scaleFreq, idx);
    if abs(g) > eps
        b = b / g;
    end
end
end

function h = idealLowpass(wcNorm, x)
% wcNorm is normalized to Nyquist, range (0, 1)
h = wcNorm * localSinc(wcNorm * x);
end

function d = deltaAtZero(x)
d = zeros(size(x));
d(x == 0) = 1;
end

function y = localSinc(x)
y = ones(size(x));
nz = x ~= 0;
y(nz) = sin(pi * x(nz)) ./ (pi * x(nz));
end

function g = responseAt(b, w, idx)
g = real(sum(b .* exp(-1j * w * idx)));
end

function w = localHamming(L)
n = (0:L-1).';
w = 0.54 - 0.46 * cos(2 * pi * n / (L - 1));
end