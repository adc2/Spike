function [h,bins]=spike_ach(spikes,binwidth,maxinterval)
%[h,bins]=spike_ach(spikes,binwidth,maxinterval) - auto-coincidence histogram
%
%  h: histogram
%  bins: (s) bin centers
%
%  spikes: spike times
%  binwidth: width of bins to count intervals [default 0.0001 s]
%  maxinterval [default 0.02 s]
%
%
% spike toolbox


if nargin==0; test_code; return; end
if nargin<2||isempty(binwidth); binwidth=0.0001; end
if nargin<3||isempty(maxinterval); maxinterval=0.02; end
    

if nargout 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [h,bins]=spike_cch(spikes,spikes,binwidth,maxinterval);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    disp('spike_ach: no output requested');    
    spike_cch(spikes,spikes,binwidth,maxinterval);
    xlim([binwidth*2,maxinterval]);
    title('AC histogram');
end
end % spike_ach


% test/example code
function test_code
    disp('spike_cch test code');
    disp('call spike_poisson, cumsum to spike times, spike_cch to plot');
    nspikes=10000;
    rate=100; % spikes/s
    spikes=cumsum(spike_poisson(nspikes,rate));
    binwidth=0.001; % 1 ms
    spike_ach(spikes, binwidth); % no output requested: plot
end % function