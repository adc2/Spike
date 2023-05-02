function ok=example_kernel(isi)
    % logarithmically decreasing kernel
    % 
    %   ok: 1 or 0 determines if spike lives or dies
    
    tau=0.001; % 1 ms time constant
    if rand>exp(-isi/tau);  ok=1; else; ok=0; end
end % function
