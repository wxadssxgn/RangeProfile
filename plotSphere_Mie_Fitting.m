clear
clc

freq_min = 1e6;
freq_max = 10e9;
samples = 500;
r = 1;
num_window = 50;

eps = 0.000001;
index = 0;
c = 3e8;
freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
k = 2 * pi * freq ./ c;
kr = k .* r;
for i = 1: length(kr)
    index = index + 1;
    sphere_rcs   = 0. + 0.*1i;
    f1 = 0. + 1.*1i;
    f2 = 1. + 0.*1i;
    m = 1.;
    n = 0.;
    q = -1.;
    del = 100000 + 100000 * 1i;
    while(abs(del) > eps)
        q = -q;
        n = n + 1;
        m = m + 2;
        del = (2 .* n - 1) * f2 / kr(i) - f1;
        f1 = f2;
        f2 = del;
        del = q * m / (f2 * (kr(i) * f1 - n * f2));
        sphere_rcs = sphere_rcs + del;
        rcs(i) = sphere_rcs;
    end
end
% wk = randn(1, 256) / 100;
% % rcs = rcs + wk;
% rcs = rcs * pi * power(r, 2);
% plot(freq, rcs);
RCS = rcs;
w = hamming(num_window)';
w(length(freq)) = 0;
rcs = w .* rcs;
RangeProfile = ifftshift(fft(rcs));
nrange = length(freq);
B = freq_max - freq_min;
r_det = c/2/B;
r_min = -(nrange - 1) / 2 * r_det;
r_max = - r_min;
r = (r_min: r_det: r_max);
Range = r;

RangeProfile_abs = abs(RangeProfile);
RangeProfile_normalization = RangeProfile_abs ./ max(RangeProfile_abs);
RangeProfile_db = 20. * log10(RangeProfile_normalization);
plot(Range, RangeProfile_db, 'k', 'linewidth', 2.0);
% axis([-15 15 -80 0]); 
xlabel('Range(m)')
ylabel('RCS(dBsm)')