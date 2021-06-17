%% Main script
% Individual distance-based SCN construction based on a reference group
% using Freesurfer segementation files (lh.aparc.stats and rh.aparc.stats). 
% Provide the directory with the subjects with the following structure:
% 
% dataFolder /
%       subject01 /
%               freesurfer/subject01/stats/lh.aparc.stats
%               freesurfer/subject01/stats/rh.aparc.stats
%       subject02 /                
%               freesurfer/subject02/stats/lh.aparc.stats
%               freesurfer/subject02/stats/lh.aparc.stats
%       etc..
%
% Age and gender column vecotrs are required for preprocessing. 
% Last, an index variable is required to identify the reference group, a 
% '0' indicates a subject for which the SCN needs to be calculated, and a 
% '1' indicates this individual is part of the reference group.
%
% Method introduced by Saggar et al. (10.1016/j.neuroimage.2015.07.006)
% Implementation by Gerhard Drenthen

% Inputs:
% dataFolder = '';
% age = []';
% sex = []';
% ref_idx = [];

% Load cortical thickness
[LHCT, RHCT, LH_RVOL, RH_RVOL] = loaddata(dataFolder);
cortical_thickness = [cell2mat(LHCT(2:end,2:end)) cell2mat(RHCT(2:end,2:end))];

% Preprocess cortical thickness
X_lin = [gender age mean(cortical_thickness,2)];
y_lin = [cortical_thickness];
[corrected_thickness] = preprocess_morph(X_lin,y_lin);

% Distance-based SCN method
idx = 1; sub_idx = find(~ref_idx); A = [];
for nn = 1:length(sub_idx)
    [Atmp, p] = corrcoef([corrected_thickness(sub_idx(nn),:); corrected_thickness(ref_idx>0,:)]);      
    Atmp(p > 0.05) = 0;
    Atmp(Atmp < 0) = 0;
    A(:,:,sub_idx) = Atmp;
end
