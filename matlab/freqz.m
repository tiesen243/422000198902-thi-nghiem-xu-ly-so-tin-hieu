function varargout = freqz(b, a, varargin)
%FREQZ Frequency response of a digital filter.
%   FREQZ(B, A) computes the frequency response without plotting.
%   FREQZ(B, A, N) uses N frequency points.
%   FREQZ(B, A, N, FS) uses sampling frequency FS (Hz).
%   [H, W] = FREQZ(...) returns complex response H and frequency vector W.
%
%   Supported options in VARARGIN:
%   - numeric scalar N (number of points)
%   - numeric scalar FS (sampling frequency in Hz)
%   - 'whole' to evaluate over [0, 2*pi)

if nargin < 1
    error('freqz:NotEnoughInputs', 'At least numerator coefficients B are required.');
end

if nargin < 2 || isempty(a)
    a = 1;
end

validateattributes(b, {'numeric'}, {'vector', 'real', 'finite'}, mfilename, 'b', 1);
validateattributes(a, {'numeric'}, {'vector', 'real', 'finite'}, mfilename, 'a', 2);

b = b(:);
a = a(:);

if all(a == 0)
    error('freqz:InvalidDenominator', 'Denominator coefficients A cannot be all zero.');
end

n = 512;
fs = [];
whole = false;

for k = 1:numel(varargin)
    arg = varargin{k};
    if ischar(arg) || (isstring(arg) && isscalar(arg))
        s = lower(char(arg));
        if strcmp(s, 'whole')
            whole = true;
        else
            error('freqz:InvalidOption', 'Unknown option: %s', s);
        end
    elseif isnumeric(arg) && isscalar(arg)
        if isempty(n) || n == 512
            n = arg;
        elseif isempty(fs)
            fs = arg;
        else
            error('freqz:TooManyNumericArgs', 'Too many numeric scalar arguments.');
        end
    else
        error('freqz:InvalidArgument', 'Unsupported argument type.');
    end
end

validateattributes(n, {'numeric'}, {'scalar', 'integer', 'positive', 'finite'}, mfilename, 'n');
if ~isempty(fs)
    validateattributes(fs, {'numeric'}, {'scalar', 'positive', 'finite', 'real'}, mfilename, 'fs');
end

if whole
    w = linspace(0, 2 * pi, n + 1).';
    w(end) = [];
else
    w = linspace(0, pi, n).';
end

kb = 0:(numel(b) - 1);
ka = 0:(numel(a) - 1);

Eb = exp(-1j * (w * kb));
Ea = exp(-1j * (w * ka));

num = Eb * b;
den = Ea * a;
tiny = 1e-12;
den(abs(den) < tiny) = tiny;
h = num ./ den;

if isempty(fs)
    wOut = w;
else
    wOut = (w / (2 * pi)) * fs;
end

if nargout > 0
    varargout{1} = h;
    if nargout > 1
        varargout{2} = wOut;
    end
end
end