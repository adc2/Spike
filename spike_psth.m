function [h,bins]=spike_psth(spikes,binwidth, stim_times)
%[h,bins]=spike_psth(spikes,binwidth,stim_times) - peri-stimulus histogram
%
%  h=histogram
%  bins: bin centers
%
%  spikes: spike times
%  binwidth: width of bins to count intervals [default 0.0001 s]
%  stim_times (array or single number) [default 0.01 s]
%
%If stim_times is a single number, it is treated as the stimulus period.
%
% spike toolbox


if nargin==0; test_code; return; end

if nargin<2||isempty(binwidth); binwidth=0.0001; end
if nargin<3||isempty(stim_times); stim_times=0.01; end
    
if numel(stim_times)==1;
    stim_times=0:stim_times:max(spikes);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stim_times=[stim_times,max(spikes)]; 
D=max(diff(stim_times));
bins=linspace(0,D,ceil(D/binwidth));
h=zeros(size(bins));
for iStim=1:numel(stim_times)-1
    segment=spikes(spikes >= stim_times(iStim) & spikes < stim_times(iStim+1));
    segment=segment-stim_times(iStim);
    h=h+hist(segment,bins);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout==0
    disp('spike_psth: no output requested, plot');
    stairs(bins,h); 
    xlim([bins(1) bins(end)])
    xlabel('time re stim (s)'); ylabel('count per bin'); title('PST histogram');
    clear h;
end

end % spike_psth


% test/example code
function test_code
    disp('spike_psth test code');
    disp('100 Hz HWR sine, max_rate 2000 spikes/s, 1 ms dead time');
    max_rate=2000; % spikes/s (larger values produce ringing)
    sr=10000; % Hz
    f=100; % Hz
    D=10; % s
    instantaneous=max(0,sin(2*pi*(1:round(sr*D)')/sr*f))*max_rate;
    reffun=0.001;
    nfibers=1;
    spikes=spike_train(instantaneous,sr,reffun,nfibers); 
    figure(1); clf
    subplot 121
    plot(linspace(0,D,numel(instantaneous)),instantaneous); xlim([0 0.02]); 
    xlabel('time (s)'); ylabel('rate (spikes/s)'); title ('instantaneous rate');
    subplot 122
    binwidth=0.0001;
    spike_psth(spikes,binwidth,1/f);
end % function


