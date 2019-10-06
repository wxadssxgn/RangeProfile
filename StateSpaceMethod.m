function Model = StateSpaceMethod(rcs, freq_min, freq_max, M)
samples = length(rcs);
freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
c = 3e8;
N = length(freq);
if mod(length(rcs), 2) == 0
    L = length(rcs) / 2;
else
    L = (length(rcs) + 1) / 2;
end
H = zeros(N - L + 1, L);
for i = 1: N - L + 1
    H(i, :) = rcs(i: L + i - 1);
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
Model = yk;
disp(tau * c / 2);
end