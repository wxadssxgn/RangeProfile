freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
justForTemp = size(CreepingReflection);
if justForTemp(1) ~= 1
    CreepingReflection = sum(CreepingReflection);
end
CreepingReflection = CreepingReflection * pi * power(r, 2);
CreepingReflection_abs = abs(CreepingReflection);
CreepingReflection_db = 20 * log10(CreepingReflection_abs);

% figure
% ana(1: 256) =  21.9842;
% ana = CreepingReflection_db + 0.001*rand(1, 256);
% plot(freq / 1e9, ana, 'k', 'linewidth', 3.5);
% hold on

plot(freq / 1e9, CreepingReflection_db, 'g', 'linewidth', 1.5);
% label = legend('PO', 'Model', 'location', 'best');
axis([freq_min / 1e9 freq_max / 1e9 min(CreepingReflection_db) - 10 max(CreepingReflection_db) + 10]);
xlabel('Frequency(GHz)')
ylabel('Amplitude(dBsm)')
