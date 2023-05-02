function [h,bins]=spike_cch(spikes1,spikes2,binwidth,maxinterval)
%[h,bins]=spike_cch(spikes1,spikes2,binwidth,maxinterval) - cross-coincidence histogram
%
%  h: histogram
%  bins: (s) bin centers
%
%  spikes1,spikes2: spike times
%  binwidth: width of bins to count intervals [default 0.0001 s]
%  maxinterval [default 0.02s]
%
% spike_cch counts only positive intervals (elements of spike2 later than
% those of spike1). To get negative intervals, swap spikes1 & spikes2
%
% spike toolbox


if nargin==0; test_code; return; end

if nargin<3||isempty(binwidth); binwidth=0.0001; end % s
if nargin<4||isempty(maxinterval); maxinterval=0.02; end  % s
spikes1=spikes1(:);
spikes2=spikes2(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shift=0;
isis=[];
while 1
    a=spikes2(shift+1:end)-spikes1(1:end-shift);
    a=a(a<maxinterval);
    if isempty(a); break; end
    a=a(a~=0); % avoids counting identical spikes when used by spike_ach
    isis=[isis; a];
    shift=shift+1;
end
bins=linspace(binwidth/2, maxinterval, ceil(maxinterval/binwidth));
h=hist(isis,bins);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargout==0
    disp('spike_cch: no output requested, plot');
    stairs(bins,h); 
    xlim([bins(1) bins(end)])
    xlabel('inter-spike interval (s)'); ylabel('count per bin'); title('cross-coincidence histogram');
    clear h;
end
end % spike_cch


% test/example code
function test_code
    disp('spike_cch test code');
    disp('call spike_poisson, cumsum to spike times, spike_cch to plot');
    nspikes=10000;
    rate=100;
    spikes=cumsum(spike_poisson(nspikes,rate));
    binwidth=0.001; % 1 ms
    spike_cch(spikes, spikes, binwidth); % no output requested: plot
    h=spike_cch(spikes, spikes, binwidth); % request output
end % function