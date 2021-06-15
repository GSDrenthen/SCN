function [LHCT, RHCT, LH_RVOL, RH_RVOL] = loaddata(dataFolder)
%% Specificy the formats of the FS stats files
format_apar = '%26s%*20*d8%*7*d8%*7s%7s%6s%[^\n\r]';
format_regvol = '%*52s%7s%[^\n\r]';

%% Allocate space
filename_lh = cell(1,1); filename_rh = cell(1,1); i = 1;
LHCT = []; LH_RVOL = []; RHCT = []; RH_RVOL = [];
fileList = ls(dataFolder);

%% Load the data from the files
for n = 3:length(fileList)
    filename_lh{n} = strcat(dataFolder,fileList(n,:),'\freesurfer\',fileList(n,:),'\stats\lh.aparc.stats');
    filename_rh{n} = strcat(dataFolder,fileList(n,:),'\freesurfer\',fileList(n,:),'\stats\rh.aparc.stats');
    
    if exist(filename_lh{n},'file') && exist(filename_rh{n},'file')
        startRow_1 = find(contains(regexp(fileread(filename_lh{n}),'\n','split'),'bankssts'));
        subjectList(i,:) = fileList(n,:);

        fileID = fopen(filename_lh{n},'r');
        if fileID > 0
            dataArray = textscan(fileID, format_apar, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines' ,startRow_1-1, 'ReturnOnError', false);
            LHCT = [LHCT; (dataArray{:,2})'];
            fclose(fileID);
            fileID = fopen(filename_lh{n},'r');
            dataArray = textscan(fileID, format_regvol, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines' ,startRow_1-1, 'ReturnOnError', false);
            LH_RVOL = [LH_RVOL; str2double(dataArray{:,1})'];
            fclose(fileID); 
        end
        fileID = fopen(filename_rh{n},'r');
        if fileID > 0
            dataArray = textscan(fileID, format_apar, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines' ,startRow_1-1, 'ReturnOnError', false);
            RHCT = [RHCT; (dataArray{:,2})'];
            fclose(fileID);
            fileID = fopen(filename_rh{n},'r');
            dataArray = textscan(fileID, format_regvol, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines' ,startRow_1-1, 'ReturnOnError', false);
            RH_RVOL = [RH_RVOL; str2double(dataArray{:,1})'];
            fclose(fileID); 
        end
        i = i + 1;
    end
end

%% Allocate imported array to column variable names
LHCT = [num2cell(subjectList,2) LHCT];
LHCT = [{'Subject_number' 'lh_bankssts_thickness' 'lh_caudalanteriorcingulate_thickness' 'lh_caudalmiddlefrontal_thickness' 'lh_cuneus_thickness' 'lh_entorhinal_thickness' 'lh_fusiform_thickness' 'lh_inferiorparietal_thickness' 'lh_inferiortemporal_thickness' 'lh_isthmuscingulate_thickness' 'lh_lateraloccipital_thickness' 'lh_lateralorbitofrontal_thickness' 'lh_lingual_thickness' 'lh_medialorbitofrontal_thickness' 'lh_middletemporal_thickness' 'lh_parahippocampal_thickness' 'lh_paracentral_thickness' 'lh_parsopercularis_thickness' 'lh_parsorbitalis_thickness' 'lh_parstriangularis_thickness' 'lh_pericalcarine_thickness' 'lh_postcentral_thickness' 'lh_posteriorcingulate_thickness' 'lh_precentral_thickness' 'lh_precuneus_thickness' 'lh_rostralanteriorcingulate_thickness' 'lh_rostralmiddlefrontal_thickness' 'lh_superiorfrontal_thickness' 'lh_superiorparietal_thickness' 'lh_superiortemporal_thickness' 'lh_supramarginal_thickness' 'lh_frontalpole_thickness' 'lh_temporalpole_thickness' 'lh_transversetemporal_thickness' 'lh_insula_thickness'}; LHCT];

for n = 2:size(LHCT,1)
    for m = 2:size(LHCT,2)
        LHCT{n,m} = str2double(LHCT{n,m});
    end
end

RHCT = [num2cell(subjectList,2) RHCT];
RHCT = [{'Subject_number' 'rh_bankssts_thickness' 'rh_caudalanteriorcingulate_thickness' 'rh_caudalmiddlefrontal_thickness' 'rh_cuneus_thickness' 'rh_entorhinal_thickness' 'rh_fusiform_thickness' 'rh_inferiorparietal_thickness' 'rh_inferiortemporal_thickness' 'rh_isthmuscingulate_thickness' 'rh_lateraloccipital_thickness' 'rh_lateralorbitofrontal_thickness' 'rh_lingual_thickness' 'rh_medialorbitofrontal_thickness' 'rh_middletemporal_thickness' 'rh_parahippocampal_thickness' 'rh_paracentral_thickness' 'rh_parsopercularis_thickness' 'rh_parsorbitalis_thickness' 'rh_parstriangularis_thickness' 'rh_pericalcarine_thickness' 'rh_postcentral_thickness' 'rh_posteriorcingulate_thickness' 'rh_precentral_thickness' 'rh_precuneus_thickness' 'rh_rostralanteriorcingulate_thickness' 'rh_rostralmiddlefrontal_thickness' 'rh_superiorfrontal_thickness' 'rh_superiorparietal_thickness' 'rh_superiortemporal_thickness' 'rh_supramarginal_thickness' 'rh_frontalpole_thickness' 'rh_temporalpole_thickness' 'rh_transversetemporal_thickness' 'rh_insula_thickness'}; RHCT];

for n = 2:size(RHCT,1)
    for m = 2:size(RHCT,2)
        RHCT{n,m} = str2double(RHCT{n,m});
    end
end