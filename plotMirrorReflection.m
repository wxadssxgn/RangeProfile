freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
MirrorReflection = sum(MirrorReflection);
MirrorReflection = MirrorReflection .* pi .* power(r, 2);
MirrorReflection_abs = abs(MirrorReflection);
MirrorReflection_db = 20 * log10(MirrorReflection_abs);
figure
hold on
% ana(1: 256) = -20.1381;
% ana = ana + 0.001*rand(1, 256);
% plot(freq / 1e9, ana, 'k', 'linewidth', 3.5);
plot(freq / 1e9, MirrorReflection_db, 'g', 'linewidth', 1.5);
% label = legend('PO', 'Model', 'location', 'best');
axis([freq_min / 1e9 freq_max / 1e9 min(MirrorReflection_db) - 0.5 max(MirrorReflection_db) + 0.5]);
xlabel('Frequency(GHz)')
ylabel('Amplitude(dBsm)')
