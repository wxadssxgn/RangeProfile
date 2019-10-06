clear
clc
freq_min = 1e9;
freq_max = 20e9;
samples = 256;
r = 0.177;
M = 10;
num_window = samples / 2;
[RCS, RangeProfile, Range, freq, freq_det] = sphereRangeProfile(freq_min, freq_max, samples, r, num_window);
N = length(freq);
c = 3e8;
if mod(length(RCS), 2) == 0
    L = length(RCS) / 2;
else
    L = (length(RCS) + 1) / 2;
end
H = zeros(N - L + 1, L);
for i = 1: N - L + 1
    H(i, :) = RCS(i: L + i - 1);
end
wk = randn(1, length(freq)) / 100;
[Usn, Ssn, Vsn] = svds(H, M);
VsnT = Vsn';
observability = Usn * power(Ssn, 0.5);
controllability = power(Ssn, 0.5) * VsnT;
ob_rf = observability(2: end,:);
ob_rl = observability(1: end - 1,:);
A = inv(ob_rl' * ob_rl) * (ob_rl' * ob_rf);
B = controllability(:, 1);
C = observability(1, :);
eigA = eig(A);
[VectorEigA, D] = eig(A);
invVectorEigA = inv(VectorEigA);
alpha = -(log(abs(eigA)) ./ freq_det);
Ri = -(c .* phase(eigA)) ./ (4 * pi * freq_det);
tau = 2 .* Ri ./ c;
for i = 1: M
    amplitude(i) = ((C * VectorEigA(:, i)) * (invVectorEigA(i, :) * B)) ./ power(eigA(i), freq_min / freq_det);
end
amplitude = amplitude.';
% amplitude = ((C * eigA) * (eigA' * B)) ./ power(eigA, freq_min / freq_det);
% amplitude = abs(amplitude);
theta = -(alpha + 1i * 2 * pi * tau) * freq;
yk = amplitude .* exp(theta);
model = sum(yk);
model_abs = abs(model);
model_db = 20 * log10(model_abs);
disp(tau * c / 2);