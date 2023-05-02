function jittered=spike_jitter(spikes,jitter)
%jittered=spike_jitter(spikes,jitter)
%
%  jittered: jittered spike times
%
%  spikes: spike times
%  jitter: array of jitters or std of Gaussian jitter [default: 0.1 ms]
%
% spike toolbox


if nargin==0; test_code; return; end

if nargin<2||isempty(jitter); jitter=0.0001; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if numel(jitter)==1;
    jitter = jitter*randn(size(spikes));
end
if numel(jitter)~=numel(spikes); error('!'); end
jittered=spikes+jitter;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout==0
    disp('spike_jitter: no output requested, plot');
    subplot 211;
    binwidth=0.00005;
    spike_ach(spikes,binwidth);
    subplot 212
    spike_ach(jittered,binwidth);
    title('jittered')
    clear jittered;
end

end % spike_jitter



% test/example code
function test_code
    disp('spike_jitter test code');
    disp('2 kHz HWR sine, max_rate 2000 spikes/s, 1 ms dead time, 0.1 ms jitter');
    max_rate=2000; % spikes/s (larger values produce ringing)
    sr=10000; % Hz
    f=2000; % Hz
    D=10; % s
    instantaneous=max(0,sin(2*pi*(1:round(sr*D)')/sr*f))*max_rate;
    reffun=0.001;
    nfibers=1;
    spikes=spike_train(instantaneous,sr,reffun,nfibers); 
    jitter=0.0001;
    spike_jitter(spikes,jitter);
end % function
