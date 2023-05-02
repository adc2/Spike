function spike_greetings
%nt_greetings - display message the first time the toolbox is used

persistent spike_greeted

if isempty(spike_greeted)
    
    display(' ');
    display(['Spike toolbox, version ',nt_version]);
    display(' ');
    display('please cite relevant papers, see README.txt');

    display(' ');
    display('WARNING: this code is under development and may radically change without notice. ');
    display('Keep an archive of this version to ensure your code works in the future.');
    display('DO NOT EXPECT YOUR CODE TO WORK WITH NEWER VERSIONS.')
    display(' ');
    
end

spike_greeted=1;