function probe_obj_func(ref_img, mov_img)


ref_img = double(ref_img);
mov_img = double(mov_img);

roi = [30,225,30,225];

% Make a cell array of all objective functions you want to try out
% The @ specifies a function handle. Don't forget the @
%obj_functions = {@sse,@sav,@joint_entropy,@xcorr_coeff};
obj_functions = {@joint_entropy, @xcorr_coeff};

% Specify the translations and rotations you want to probe
% For now just do dx,dy
delta_xs   = linspace(-100,101,50); 
delta_ys   = linspace(-100,101,50);
thetas     = 0;
%thetas = linspace(-5,5,pi/8);

% Set this variable to 1 to show the image transformations as we probe
ploton = -1;

% Call function 'probe'
surfaces = probe(ref_img, mov_img, roi, obj_functions, delta_xs,delta_ys,thetas,ploton);


% Plot Results
tIndx = 1;
[foo,cx] = min(abs(delta_xs));
[foo,cy] = min(abs(delta_ys));
sign = [1 1 1 -1];

for f=1:length(obj_functions)
  figure(655+f); clf; set(gcf,'Position',[1 1 1200 300]);
  %subplot(1,3,1);
  subplot(1,2,1);

  surf(delta_xs,delta_ys,surfaces{f}(:,:,tIndx)); colormap default; colorbar;
  xlabel('\delta_x');ylabel('\delta_y'); zlabel(func2str(obj_functions{f}),'interpreter','none');
  title(['Probe surface using ' func2str(obj_functions{f})],'interpreter','none');
  
  %subplot(1,3,2);
  subplot(1,2,2);
  contour(delta_xs,delta_ys,surfaces{f}(:,:,tIndx),100,'lineWidth',1);colormap default;
  [mis,mxs] = local_extrema(surfaces{f}(:,:,tIndx));
  [gmi,gmx] = global_extrema(surfaces{f}(:,:,tIndx));
  hold on;
  plot(delta_xs(mxs{2}),delta_ys(mxs{1}),'kx','lineWidth',2,'MarkerSize',8);
  plot(delta_xs(mis{2}),delta_ys(mis{1}),'ko','lineWidth',2,'MarkerSize',8);
  plot(delta_xs(gmx{2}),delta_ys(gmx{1}),'kd','lineWidth',2,'MarkerSize',12);
  plot(delta_xs(gmi{2}),delta_ys(gmi{1}),'ks','lineWidth',2,'MarkerSize',12);
  xlabel('\delta_x');ylabel('\delta_y');
  title(['Probe surface contours using ' func2str(obj_functions{f})],'interpreter','none');
  
%   subplot(1,3,3);
%   c = capture_region(sign(f)*surfaces{f}(:,:,tIndx),[cy;cx]);
%   imagesc(delta_xs,delta_ys,c,[0 1]);
%   xlabel('\delta_x');ylabel('\delta_y');
%   p = 100*length(find(c(:)==1))/length(c(:));
%   title(['Capture Region ' num2str(p) '%']);
end