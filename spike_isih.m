function [h,bins]=spike_isih(spikes,binwidth)
% [h,bins]=spike_isi(spikes,binwidth) - first-order interspike interval histogram
%
%  h: histogram
%  bins: (s) bin centers
%
%  spikes: array of spike times
%  binwidth: s, width of histogram bins
%  The size of the histogram may vary depending on the largest interval in 
%  the spike train. 
%
% spike toolbox

if nargin==0; test_code; return; end

if nargin<2||isempty(binwidth); binwidth=0.001; end % 1ms

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isis=diff(spikes);
bins=linspace(binwidth/2, max(isis), ceil(max(isis)/binwidth));
h=hist(isis,bins);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout==0
    disp('spike_isi: no output requested, plot');
    stairs(bins,h); 
    xlim([bins(1) bins(end)])
    xlabel('inter-spike interval (s)'); ylabel('count per bin'); title('first order ISI histogram');
    clear h;
end
end % spike_isih


% test/example code
function test_code
    disp('spike_isi test code');
    disp('call spike_poisson, cumsum to spike times, spike_isih to plot');
    nspikes=10000;
    rate=100;
    spikes=cumsum(spike_poisson(nspikes,rate));
    binwidth=0.001; % 1 ms
    spike_isih(spikes, binwidth); % no output requested: plot
    % h=spike_isi(spikes, binwidth); % output requested
end % function