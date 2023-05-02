function isis = spike_poisson(nspikes, rate)%isis=spike_poisson(nspikes, rate) - simulation of poisson process%%  isis : array of interspike intervals%  %  nspikes: number of interspike intervals%  rate: nominal rate (spikes/s)% % spike toolboxif nargin==0; test_code; return; end % demo & testif nargin<2; error('!'); end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% uniformly distributed random numbers, no zeroswhile 1	isis = rand(fix(nspikes),1);	if all(find(isis)) break; end;end% intervals of Poisson process are log distributedisis = -log(isis) / rate;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%if nargout==0    disp('spike_poisson: no output requested, plot ISI histogram');    spike_isih(cumsum(isis)); % expects spike times    clear spikesendend % function% test/example codefunction test_code    disp('spike_poisson test code');    nspikes=100000; % number of interspike intervals    rate=100; % nominal rate    spike_poisson(nspikes,rate); % no output: plotend % function