function showSerTight_ref(ser, ref,figNum)

%
% Author: emiller
% Show mosaic of registered image with reference image contours on the
% background
%

figure(figNum);
clf;

row=ceil(sqrt(size(ser,3))-.000001);
margin=1/(row*10+(row+1));
spacePerRow=11*margin;

for i=1:size(ser,3)
  curRow=ceil(i/row)-1;
  curCol(i)=mod(i-1,row);
  top=1-(curRow*spacePerRow+margin);
  bot=1-((curRow+1)*spacePerRow);
  left=curCol(i)*spacePerRow+margin;
  right=(curCol(i)+1)*spacePerRow;
  subplot('position',[left,bot,right-left,top-bot]);
  imagesc(ser(:,:,i));
  hold on, contour(ref(:,:,i),[0 0],'g','linewidth',1); 
  axis off;
  colormap('gray');
  hold off;
end

drawnow;
