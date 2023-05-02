function spikes_out=spike_cancel(spikes_in,spikes_gate,delay,kernel)
%spikes_out=spike_cancel(spikes_in,spikes_gate,delay,kernel) - neural cancellation filter
%
%  spikes_out: filtered spike times
% 
%  spikes_in: input spike times
%  spikes_gate: gating spike times
%  delay: (s) filter parameter
%  kernel: coincidence kernel function [default: 0.0001 s boxcar]
%
% Input spikes that coincide with a gating spike that occurred 'delay'
% earlier in time are likely to be removed. Probability is modulated by the
% shape of the kernel function (analogous to a post-synaptic potential).
%
% spikes toolbox


if nargin==0; test_code; return; end

if nargin<3; error('!'); end
if nargin<4; kernel=0.0001; end

if ~isa(kernel, 'function_handle')
    kernel=@(isi) double(isi>kernel); % 1 if isi greater than value, else 0
end

% kludge to find the useful width of kernel (saves computation)
threshold=0.01; % below this is negligible
start_interval=10; % s
isi=start_interval;
ntrials=1000;
while 1
    oks=zeros(ntrials,1);
    for iTrial=1:ntrials; oks(iTrial)=kernel(isi); end
    if mean(oks)<1-threshold; break; end
    isi=isi/2;
end
kernel_width=isi; % no need to consider larger isis
    
spikes_in=spikes_in(:);
spikes_gate=spikes_gate(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iSpike_out=1; spikes_out=[];
for iSpike_in=1:numel(spikes_in)
    isis=spikes_in(iSpike_in)-spikes_gate+delay;
    a=isis(isis>=0 & isis<kernel_width);
    ok=1;
    for iA=1:numel(a)
        ok=ok * kernel(a(iA)); 
    end
    if ok
        spikes_out(iSpike_out)=spikes_in(iSpike_in);
        iSpike_out=iSpike_out+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(spikes_out); warning('all spikes eliminated'); end

if nargout==0
    disp('spike_cancel: no output requested, plot');
    figure(1); clf
    binwidth=0.0001;
    maxinterval=0.1;
    subplot 211
    spike_ach(spikes_in,binwidth,maxinterval);
    subplot 212
    spike_ach(spikes_out,binwidth,maxinterval);
    title(['cancellation filtered, delay = ',num2str(delay)])
    disp(['rates in and out (spikes/s): ', num2str([spike_rate(spikes_in),spike_rate(spikes_out)])]);
    clear spikes_out
end

end % spike_cancel



% example of a kernel
function ok=example_kernel(isi)
    % logarithmically decreasing kernel
    % 
    %   ok: 1 or 0 determines if next spike lives or dies
    
    tau=0.0003; % 1 ms time constant
    if rand>exp(-isi/tau);  ok=1; else; ok=0; end
end % function



% test/example code
function test_code
    disp('spike_cancel test code');
    disp('100 Hz HWR sine, max_rate 2000 spikes/s, 1 ms dead time');
    max_rate=2000; % spikes/s (larger values produce ringing)
    sr=10000; % Hz
    D=10; % s
    f1=100; % Hz
    f2=125; % Hz
    instantaneous=max(0,...
        sin(2*pi*(1:round(sr*D)')/sr*f1)+...
        sin(2*pi*(1:round(sr*D)')/sr*f2)...
        )*max_rate;
    reffun=0.00; % --> 1 ms dead time
    nfibers=10;
    spikes_in=spike_train(instantaneous,sr,reffun,nfibers); 
    spikes_gate=spikes_in; 
    %kernel=0.001; % 0.1 ms boxcar
    kernel=@example_kernel; 
    binwidth=0.0001;
    maxinterval=0.1;
    subplot 311
    spike_ach(spikes_in,binwidth,maxinterval);
    subplot 312
    delay=1/f1; % s
    spikes_out=spike_cancel(spikes_in,spikes_gate,delay,kernel);
    spike_ach(spikes_out,binwidth,maxinterval);
    title(['cancellation filtered, delay (s) = 1/',num2str(f1)])
    disp(['rates in and out (spikes/s): ', num2str([spike_rate(spikes_in),spike_rate(spikes_out)])]);
    subplot 313
    delay=1/f2; % s
    spikes_out=spike_cancel(spikes_in,spikes_gate,delay,kernel);
    spike_ach(spikes_out,binwidth,maxinterval);
    title(['cancellation filtered, delay (s) = 1/',num2str(f2)])
    disp(['rates in and out (spikes/s): ', num2str([spike_rate(spikes_in),spike_rate(spikes_out)])]);
    clear spikes_out
end % function
