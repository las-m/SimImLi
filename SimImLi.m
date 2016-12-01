function result = SimImLi(varargin)
%% SimulateImaging simulates different effects of the imaging system
% 
% TODO: 

%% initialize input parser
p = inputParser;
p.addParameter('s', 1); % saturation I/Isat
p.addParameter('time', 5e-6); % Imaging pulse length in s
p.addParameter('resolution', 1e-9); % Time resolution of simulation in s
p.addParameter('verbose', 1); % show results in verbose mode
p.addParameter('initialDetuning', 0); % detuning to start with in units of gamma
p.addParameter('imagingline', 'D2'); % define transition to work on
p.addParameter('doChirp', [1 0 1.1573]); % do chirp of imaging laser frequency to compensate for the doppler shift
p.addParameter('ncol', 1e12); % column density in 1/m^2
p.addParameter('doFullSimulation', false); % do full simulation including a simulation of the density distribution after TOF
p.addParameter('TOF', 10e-6); % time of flight in s
p.addParameter('numPart', 1000); % number of particles to simulate 
p.addParameter('initWidth', 2e-6); % initial cloud width in m

%% parse results
parse(p, varargin{:});
s = p.Results.s;
t = p.Results.time;
deltat = p.Results.resolution;
v = p.Results.verbose;
initialDetuning = p.Results.initialDetuning;
imagingline = p.Results.imagingline;
doChirp = p.Results.doChirp;
ncol = p.Results.ncol;
TOF = p.Results.TOF;
doFullSimulation = p.Results.doFullSimulation;
numPart = p.Results.numPart;
initWidth = p.Results.initWidth;

%% load property files and define properties
% add matlab library folder to path
addpath(genpath('Z:\Informatics\Matlab'),'-frozen');

% load all system parameters
LoadSystemParameters

% line used for imaging
gamma = gamma.(imagingline); % in MHz ? or radian?
vrecoil = vrecoil.(imagingline);
f0 = f0.(imagingline);


%% perfect chirp
perfectChirp = 2*Erec.(imagingline)/(hbar*2*pi)*2*pi/2*(s/(1+s+(2*initialDetuning/gamma)^2))*t;

%% do actual calculations
% calculate the number of steps to simulate
timesteps = ceil(t/deltat);

if doChirp(1)
    % calculate compensation for the detuning
    detuningComp = doChirp(2):(doChirp(3)-doChirp(2))/timesteps:doChirp(3);
    detuningComp = detuningComp*gamma;
else
    detuningComp = zeros(timesteps, 1);
end 

% preallocate memory
detuning = zeros(timesteps, 1);
scatteringrate = zeros(timesteps, 1);
velocity = zeros(timesteps, 1);
position = zeros(timesteps, 1);
photonsscattered = zeros(timesteps, 1);
photonsdetectedperpix = zeros(timesteps, 1);
photonsscatteredperpix = zeros(timesteps, 1);
randomwalk = zeros(timesteps, 1);
timepassed = zeros(timesteps, 1);
partPos = zeros(timesteps, numPart);
partPos(1,:) = normrnd(0,initWidth,numPart,1);
partVelo = zeros(timesteps, numPart);
partDetuning = zeros(timesteps, numPart);
partScatteringRate = zeros(timesteps, numPart);
partPhotonsscattered = zeros(timesteps, numPart);

% calculate the unperturbed value for the scattering rate
detuning(1) = initialDetuning*gamma - detuningComp(1);
scatteringrate(1) = gamma*2*pi/2*(s/(1+s+(2*detuning(1)/gamma)^2)); % scattering rate

% run loop
for i = 2:timesteps
    % detuning due to the doppler shift. The initial detuning can be set.
    % See the wiki entry Absorption imaging for more details.
    detuning(i) = detuning(1) - detuningComp(i) + ...
        2*Erec.(imagingline)/(hbar*2*pi)*photonsscattered(i-1);
    % scattering rate in dependence of the detuning calculated above
    scatteringrate(i) = gamma*2*pi/2*(s/(1+s+(2*detuning(i)/gamma)^2));
    photonsscattered(i) = photonsscattered(i-1) + scatteringrate(i)*deltat;
    photonsscatteredperpix(i) = photonsscattered(i)*EffectivePixelArea*Transmission*QEfficiency*ncol;
    photonsdetectedperpix(i) = Isat.(imagingline)*s*i*deltat*EffectivePixelArea/(hbar*2*pi*f0)*Transmission*QEfficiency;
    % Change in velocity of the cloud.
    velocity(i) = velocity(i-1) + scatteringrate(i)*deltat*vrecoil;
    position(i) = position(i-1) + velocity(i)*deltat;
    timepassed(i) = (i-1)*deltat;
    randomwalk(i) = sqrt(photonsscattered(i)/3)*vrecoil*timepassed(i);

    if doFullSimulation
        % calculate detuning of single particle 
        partDetuning(i,:) = detuning(1) - detuningComp(i) + 1/(lightspeed/f0)*partVelo(i-1);
        % calculate corresponding scattering rage
        partScatteringRate(i,:) = gamma*2*pi/2*(s/(1+s+(2*partDetuning(i)/gamma).^2));
        % calculate number of photons being scattered so far
        partPhotonsscattered(i,:) = partPhotonsscattered(i-1) + partScatteringRate(i)*deltat;
        % calculate velocity of particles
        partVelo(i,:) = partVelo(i-1,:) + partScatteringRate(i,:)*deltat*vrecoil + round(rand(numPart,1)*2-1)'.*sqrt(partScatteringRate(i,:)*deltat/3)*vrecoil;

        partPos(i,:) = partPos(i-1,:) + partVelo(i,:)*deltat;
    end
end

if TOF
    partPos(i+1,:) = partPos(i,:) + partVelo(i,:)*TOF;
end

%% plot results if verbose
if v
    if doFullSimulation
        figure(2), hist(partPos(end,:),100);
        xlabel('Binned Particle Distribution after TOF','Interpreter','latex');
        ylabel('Number of Particles per Bin','Interpreter','latex');
%         for i = 1:timesteps
%             [cts(i,:), pos(i,:)] = histcounts(partPos(i,:), 50);
%             ts(i,1:50) = i * deltat;
%         end
    end
    g = figure(1);
    clf;
    xlabeltext = 'Time during imaging pulse [$\mu s$]';
    xmax = 3;
    ymax = 3;
    % plot detuning
    subplot(xmax,ymax,1);
    plot(timepassed*1e6, detuning./gamma);
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Detuning [$\Gamma$]','Interpreter','latex');
    
    % plot position
    subplot(xmax,ymax,2);
    plot(timepassed*1e6, position*1e6);
    line([timepassed(1) timepassed(end)]*1e6, [DOF.LargeNA*1e6 DOF.LargeNA*1e6], 'Color', 'red');
    maxtimepos = timepassed(position > DOF.LargeNA);
    if numel(maxtimepos)
        maxtimepos = maxtimepos(1);
        line([maxtimepos maxtimepos]*1e6, [0 DOF.LargeNA*1e6], 'Color', 'red');
    end
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Mean position of the atoms [$\mu m$]','Interpreter','latex');
    l = legend('Atom Position', 'Depth of field');
    set(l, 'Interpreter', 'latex', 'EdgeColor', [1 1 1]);
    
    % plot scattering rate
    subplot(xmax,ymax,3);
    plot(timepassed*1e6, scatteringrate*1e-6);
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Scattering rate [$\mu s^{-1}$]','Interpreter','latex');
    
    % plot velocity
    subplot(xmax,ymax,4);
    plot(timepassed*1e6, velocity);
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Velocity of the cloud [$m/s$]','Interpreter','latex');
    
    % plot photons scattered
    subplot(xmax,ymax,5);
    plot(timepassed*1e6, photonsscattered);
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Photons scattered [1]','Interpreter','latex');
    
    % plot random walk
    subplot(xmax,ymax,6);
    plot(timepassed*1e6, randomwalk*1e6);
    line([timepassed(1) timepassed(end)]*1e6, [R*1e6 R*1e6], 'Color', 'red');
    maxtimerw = timepassed(randomwalk > R);
    if maxtimerw
        maxtimerw = maxtimerw(1);
        line([maxtimerw maxtimerw]*1e6, [0 R*1e6], 'Color', 'red');
    end
    xlabel(xlabeltext,'Interpreter','latex');
    ylabel('Randomwalk $r_{rms}$ in $xy$-plane [$\mu m$]','Interpreter','latex');
    l = legend('Mean random walk $r_{rms}$', 'Diffraction limited resolution');
    set(l, 'Interpreter', 'latex', 'EdgeColor', [1 1 1]);
    
    % plot S/N
%     subplot(xmax,ymax,7);
%     plot(timepassed*1e6, photonsscatteredperpix./sqrt(photonsdetectedperpix));
%     % calculate the point where S/N > 1
%     maxtimesn = timepassed(photonsscatteredperpix./sqrt(photonsdetectedperpix) > 1);
%     if maxtimesn
%         maxtimesn = maxtimesn(1);
%         line([maxtimesn maxtimesn]*1e6, [0 1], 'Color', 'red');
%     end
%     xlabel(xlabeltext,'Interpreter','latex');
%     ylabel('Signal to noise','Interpreter','latex'); 
    
    % display single number results
    h = annotation(g, 'textbox', [0.4 0.05, 0.2, 0.2], 'String', {[num2str(max(photonsscattered(:)),4) ' Photons being scattered per atom'], ...
        ['Pulse duration limited by z-position shift: ' num2str(maxtimepos*1e6,3) '$\mu s$'], ...
        ['Pulse duration limited by random walk: ' num2str(maxtimerw*1e6,3) '$\mu s$'], ...
        ['Pulse duration limited by $S/N > 1$: ' num2str(maxtimerw*1e6,3) '$\mu s$'], ...
        ['Slope of chirp: ' num2str(doChirp(3)*gamma*1e-6/(t*1e6), 3) '$MHz/\mu s$'], ...
        ['Delta of chirp: ' num2str(doChirp(3)*gamma*1e-6, 3) '$MHz$ in ' num2str(t*1e6,2) '$\mu s$'], ...
        ['Perfect chirp: ' num2str(perfectChirp*gamma*1e-6, 3) '$MHz$ in ' num2str(t*1e6,2) '$\mu s$'], ...
        ['Perfect chirp: ' num2str(perfectChirp, 3) '$\Gamma$ in ' num2str(t*1e6,2) '$\mu s$']}, ...
        'Interpreter', 'Latex', 'LineStyle', 'none', 'FitBoxToText', 'on', 'FontSize', 12);
end

% set to fullscreen
set(gcf,'units','normalized','outerposition',[0 0 1 1]);

%% write everything to result variable
result.velocity = velocity;
result.photonsscattered = photonsscattered;
result.scatteringrate = scatteringrate;
result.timepassed = timepassed;
result.position = position;
result.detuning = detuning;
result.chirp = perfectChirp*gamma;
result.time = t;

end
