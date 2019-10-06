samples = length(rcs);
freq_det = (freq_max - freq_min) / (samples - 1);
freq = (freq_min: freq_det: freq_max);
modelsum = sum(model);
model_abs = abs(modelsum);
model_db = 20 * log10(model_abs);
plot(freq / 1e9, abs(rcs), 'k', 'linewidth', 3.0);
hold on
plot(freq / 1e9, model_abs, 'g', 'linewidth', 0.9);
% label = legend('Analytical', 'Model', 'location', 'best');
label = legend('Measurement', 'Model', 'location', 'best');
axis([freq_min / 1e9 freq_max / 1e9 min(abs(rcs)) max(abs(rcs))]); 
% axis([freq_min / 1e9 freq_max / 1e9 min(model_abs) max(model_abs)]); 
xlabel('Frequency(GHz)')
% ylabel('RCS/\pir^{2}')
ylabel('RCS')
