function build_mosaic(directory)


files = dir(strcat(directory,'/mask/*.tif'));
nFiles = length(files);
mask_ext = '_mask.tif';

plotCols = 8;
plotRows = ceil(nFiles/plotCols);

for f=1:nFiles

    ind = findstr(files(f).name,mask_ext);
    name = files(f).name(1:ind-1);    
    img_name = strcat(directory,'/',name);     
    image = imread(img_name);
    image = imresize(image,0.25);    
    
    mask_name = strcat(directory,'/mask/',files(f).name);    
    mask = imread(mask_name);
    
    image = imresize(image,0.5);
    mask = imresize(mask,0.5);
    
    h = subplot(plotRows,plotCols,f);    
    ax=get(h,'Position');
    %ax(3)=ax(3)+0.05;
    ax(4)=ax(4)+0.05; 
    set(h,'Position',ax);     
    
    imshow(image);
    hold on, contour(mask,[0 0],'g','linewidth',1);    
    
end