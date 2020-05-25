function TransTrk2Vtk(filename)
%% transform trk file to vtk files
% 
%%
[pathstr,name,ext] = fileparts(filename);
newname=strcat(pathstr,filesep,name,'.vtk');

[h t]=trk_read(filename);

numTracks=length(t);
  
    fid = fopen(newname, 'w'); 
% VTK files contain five major parts
% 1. VTK DataFile Version
    fprintf(fid, '# vtk DataFile Version 2.0\n');
% 2. Title
    fprintf(fid, 'VTK from Matlab\n');
    fprintf(fid, 'ASCII\n');

for i=1:numTracks
    if(i==1)
        x=t(i).matrix(:,1);
        y=t(i).matrix(:,2);
        z=t(i).matrix(:,3);
%        disp(strcat(num2str(i),':',num2str(length(t(i).matrix(:,1))),num2str(length(t(i).matrix(:,2))),num2str(length(t(i).matrix(:,3)))))
    else
        x=vertcat(x,t(i).matrix(:,1));
        y=vertcat(y,t(i).matrix(:,2));
        z=vertcat(z,t(i).matrix(:,3));
%        disp(strcat(num2str(i),':',num2str(length(t(i).matrix(:,1))),num2str(length(t(i).matrix(:,2))),num2str(length(t(i).matrix(:,3)))))
%        disp(strcat(':',num2str(length(x)),num2str(length(y)),num2str(length(z))))
    end
end
    n_elements = numel(x);
    fprintf(fid, 'DATASET POLYDATA\n');
    nbpoint = numel(x);
    fprintf(fid, ['POINTS ' num2str(nbpoint) ' float\n']);
    precision = '3';

    spec = [repmat(['%0.',precision,'f '],1,3),'\n'];
    fprintf(fid,spec, [x y z]');
%%
tmp=0;
for i=1:numTracks
    x=t(i).matrix(:,1);
    y=t(i).matrix(:,2);
    z=t(i).matrix(:,3);
     
    n_elements = numel(x);
    if mod(n_elements,2)==0
        nbLine = 2*n_elements-2;
    else
        nbLine = 2*(n_elements-1);
    end

    tmp=tmp+nbLine;
end    
nbLine=tmp;
fprintf(fid,'\nLINES %d %d\n',nbLine,3*nbLine);

%%
tmp=0;
for i=1:numTracks
    x=t(i).matrix(:,1);
    y=t(i).matrix(:,2);
    z=t(i).matrix(:,3);
     
    n_elements = numel(x);
    nbpoint = numel(x);
    precision = '3';
               
    if mod(n_elements,2)==0
        nbLine = 2*n_elements-2;
    else
        nbLine = 2*(n_elements-1);
    end

    conn1 = zeros(nbLine,1);
    conn2 = zeros(nbLine,1);
    conn2(1:nbLine/2) = 1:nbLine/2;
    conn1(1:nbLine/2) = conn2(1:nbLine/2)-1;
    conn1(nbLine/2+1:end) = 1:nbLine/2;
    conn2(nbLine/2+1:end) = conn1(nbLine/2+1:end)-1;
    conn1=conn1+tmp;
    conn2=conn2+tmp;            
    tmp=tmp+length(t(i).matrix);            
    fprintf(fid,'2 %d %d\n',[conn1';conn2']);  
    if(i~=numTracks)
        fprintf(fid,'\n');
    end
end
fclose(fid);
end
