RangeProfile_abs = abs(RangeProfile);
RangeProfile_normalization = RangeProfile_abs ./ max(RangeProfile_abs);
RangeProfile_db = 20. * log10(RangeProfile_normalization);
plot(Range, RangeProfile_db, 'k', 'linewidth', 2.0);
axis([-15 15 -80 0]); 
xlabel('Range(m)')
ylabel('RCS(dBsm)')
