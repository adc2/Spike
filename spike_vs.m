function v=spike_vs(spikes,T)
%v=spike_vs(spikes,T) - vector strength
%
%  v: vector strength
%
%  spikes: (s) spike times
%  T: (s) period
%
% spikes toolbox

if nargin==0; test_code; return; end

if nargin<2; error('!'); end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phases=(spikes-T*floor(spikes/T))/T*2*pi;
v = sqrt(sum(cos(phases)).^2 + sum(sin(phases)).^2)/numel(phases);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~nargout
    disp('spike_vs: no output requested, print'); 
    disp(['vector strength: ', num2str(v)]);
end

end % spike_vs


% test/example code
function test_code
    disp('spike_vs test code');
    disp('100 Hz HWR sine, max_rate 1000 spikes/s, 1 ms dead time');
    max_rate=1000; % spikes/s
    sr=44100; % Hz, sampling rate of driving function
    f=100*sqrt(2); % Hz
    D=10; % s
    drive=max(0,sin(2*pi*(1:round(sr*D)')/sr*f))*max_rate;
    recfun=0.001;
    nfibers=1;
    spikes=spike_train(drive,sr,recfun,nfibers); 
    spike_vs(spikes,1/f);
end % function
