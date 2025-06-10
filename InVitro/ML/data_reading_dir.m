function image_mean1=data_reading_dir

yCell = readcell('Cell_directedness.csv');

%display('bye')
jjjj=size(yCell);
jjjj=jjjj(1)-1;
%jjjj=ans;
for i=2:jjjj+1
    M=yCell(i,2);
    N=M{1,1};
    N(1)=[];
    k=length(N);
    N(k)=[];
    N=cellstr(N);
    newB{1,i-1} = cellfun(@(x) strsplit(x, ','), N, 'UniformOutput', false);
end
store=[];
image_mean1=0;
for i=1:jjjj
    store=[store str2num(newB{1,i}{1,1}{1,end})];
    image_mean1=image_mean1+store(i);
    
end

image_mean1 = image_mean1/jjjj %double check
end