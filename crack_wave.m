function z = crack_wave(x,t,b,g,H)

% convert instantaneous seafloor uplift b(x)
% to tsunami waveform z(x,t) using linear theory
% (but including dispersion of short wavelengths)
% in ocean of depth H with gravity g
  
% x = N grid points with uniform grid spacing h
% x = [0:h:L-h] where L=N*h is total domain
% (note absence of point at x=L due to periodicity)

  N = length(x);
  
  h = x(2)-x(1);
  if norm(diff(x)-h)>1e-11
    disp('error, must have uniform grid spacing')
    return
  end
  
  % wavenumber
  
  kN = pi/h; % Nyquist wavenumber
  
  k = zeros(1,N);
  k(1:N/2+1) = 2*[0:N/2]/N;
  k(N:-1:N/2+2) = -k(2:N/2);
  k = k*kN;

  % b(x) = seafloor displacement
  
  b_mean = mean(b);

  % excitation in Fourier domain

  B = fft(b-b_mean);
  
  B(N/2+1) = B(N/2+1)/2; % handle Nyquist properly

  % dispersion relation

  CreateFracture;
  M.x = k;  M.type='FixedWavenumber';
  omega = RootFinder(ProcVarArg(M)) .* k .* c0;

  % sea surface, with Kajiura cosh(kH) "filter" 
  % when converting from seafloor to sea surface,
  % cos(omega*t) is propagation factor involving waves
  % in each direction

  Z = B./cosh(k*H).*cos(omega*t); 

  % inverse Fourier transform

  z = ifft(Z)+b_mean;
