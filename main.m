clear
clc
M = 10;
data = load('C:\Users\iamtyz\Desktop\±¨¸æ\data\00.txt');
re = data(:, 5)';
im = data(:, 6)';
r = 2;
rcs = re+1i*im;
freq_min = 0.1e9;
freq_max = 0.6e9;
samples = length(rcs);

[RangeProfile, Range] = rangeProfile(rcs, freq_min, freq_max, samples);
model = StateSpaceMethod(rcs, freq_min, freq_max, M);

CreepingReflection = model(4: 6, :);
MirrorReflection = model(8: 10, :);
