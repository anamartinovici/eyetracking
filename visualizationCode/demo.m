% Zoya Bylinskii, October 19, 2015
% https://github.com/massvis
% massvis.mit.edu


%% set parameters for visualization purposes

params = struct();
params.thresh = 0.1;
params.sigma = 32;
params.scaleFact = 4; % a larger number speeds up computation

%% if you want to accumulate fixations from the massvis dataset:
% if you want to input your own images or fixations, skip to the code below

load('allImages.mat');
addpath('utils');

whichfix = 'enc'; % or 'rec'
whichim = 1;
% whichusers = [3,4,5]; 
% to use all users:
whichusers = 1:length(allImages(whichim).userdata); 

% accumulate fixations from multiple users

im = imread(allImages(whichim).impath);
imsize = [size(im,1),size(im,2)];
maxsize = max(imsize(1),imsize(2));

fixations = [];
for j = 1:length(whichusers)
    
    whichuser = whichusers(j);
    
    % check if fixations exist for this user and include them if they do
    if isempty(allImages(whichim).userdata(whichuser).fixations) || ...
            ~isfield(allImages(whichim).userdata(whichuser).fixations,whichfix) || ...
            isempty(allImages(whichim).userdata(whichuser).fixations.(whichfix))
        continue;
    end
    
    fixdata = allImages(whichim).userdata(whichuser).fixations.(whichfix);
    fixations = [fixations ; fixdata];

end
    
%% plot fixation heatmap

plotFixationHeatmap(im, fixations, params);

%% plot coverage map

plotCoverageMap(im, fixations, params); 
   

     