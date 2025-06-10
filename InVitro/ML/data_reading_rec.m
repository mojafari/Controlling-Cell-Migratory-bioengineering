function image_mean1=data_reading_rec

yCell = readcell('Recruitment_Index_vals.csv');

%display('bye')

M=yCell(2:end,2);
N=M{end,1};


image_mean1 = N %double check
end