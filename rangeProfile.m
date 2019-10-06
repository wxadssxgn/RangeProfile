function [RangeProfile, Range] = rangeProfile(rcs, freq_min, freq_max, samples)
c = 3e8;
num_window = samples / 2;
freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
w = hamming(num_window)';
w(length(freq)) = 0;
rcs = w .* rcs;
RangeProfile = ifftshift(ifft(rcs));
nrange = length(freq);
B = freq_max - freq_min;
r_det = c/2/B;
r_min = -(nrange - 1) / 2 * r_det;
r_max = - r_min;
r = (r_min: r_det: r_max);
Range = r;
end