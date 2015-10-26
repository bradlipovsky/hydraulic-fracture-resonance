% What are the harmonic frequencies of a fracture of length L?
% Run this after running PhaseVelocity_RealK


L = 10;
nh=10;
harmonics = 1:nh;
wavelengths = 2*L./harmonics;
wavenumbers = 2*pi./wavelengths;
f = zeros(nh,1);fc=f;
for i = 1:nh
    cpi = interp1(k,cp,wavenumbers(i));
    f(i) = cpi / wavelengths(i);
    fc(i) = 0.0634 / wavelengths(i); %number is min(cpi)
end

plot(f,wavelengths,'-ok'); hold on;
plot(fc,wavelengths,'-ob');
xlabel('frequency');
ylabel('wavelength');