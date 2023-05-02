Routines to generate, process, and analyze spike trains (the main application is modeling auditory nerve patterns).

Spikes are represented by their absolute time with arbitrary resolution (double precision).
No sampling is involved. Computation and storage are efficient.

Spike generation is an inhomogenous Poisson process with a refractory function or dead time, implemented a homogenous 
Poisson process (ISIs distributed logarithmically) followed by a thinning process to 
enforce a time-varying firing rate, and another thinning process to enforce a refractory function/dead time.

All functions include test/example code.

Alain de Cheveigné, CNRS/ENS, 26 Feb 2023.

 


---
Useful references:

Lewis PAW, Shedler GS (1979), Simulation of nonhomogeneous Poisson processes by thinning.
Naval Res. Logistics Quart. 26:403–413. 
[original (?) paper on thinning a homogenous Poisson process]

de Cheveign{\'e}(1985), A nerve fiber discharge model for the study of pitch, Transactions of the 
Committee on Speech Research/Hearing Research, The Acoustical Society of Japan, Tokyo, S85-37:279--286.
[my early work on spike generation]

Delgutte, B (1996) Physiological models for basic auditory percepts, Auditory computation, 157-220
[recovered from https://web.mit.edu/HST.722/www/Topics/Quantitative/Delgutte96.pdf] 
[reviews early 
work suggesting that AN firing is well described by an inhomogenous Poisson process with refractory effects.]

Brette, R. (2009) Generation of Correlated Spike Trains, Neural Comput 2009; 21 (1): 188–215. 
doi: https://doi.org/10.1162/neco.2009.12-07-657'. 
[wider perspective] 

Heil, P. and Peterson, A.J. (2017), Spike timing in auditory-nerve fibers during spontaneous activity and phase locking. Synapse, 71: 5-36. https://doi-org.insb.bib.cnrs.fr/10.1002/syn.21925. 
[auditory-nerve spike generation is more than a Poisson process]

