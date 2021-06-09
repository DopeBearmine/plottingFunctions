function rotatePlot


nFrames = 360;

[currentAz, currentEl] = view;
az = 0:nFrames+currentAz;
el = ones(1,nFrames)*currentEl; % sin(az*period)*amplitude
for f = 1:nFrames
    view(az(f), el(f))
    pause(0.1)
end
