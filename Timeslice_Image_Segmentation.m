%% Exemplary code for application of image segmentation algorithm to GPR data

% Author: Luis Rees-Hughes, University of Leeds, 2020

% This script segments GPR timeslice data from the Llanbedr 3D GPR dataset
% used in the accompanying paper manuscript.

clear all
close all

% Download and add SegyMAT Toolbox: https://github.com/cultpenguin/segymat
%% 1) Read in Llanbedr GPR Data
% Download and add SegyMAT Toolbox: https://github.com/cultpenguin/segymat
% Creates a cell array of every timeslice in the 3D GPR Data Volume
% Read in the .sgy file

[data,SegyTraceHeaders,SegyHeader]=ReadSegy('Llanbedr_mig_gain2.sgy'); 

%% 2) Data Normalization - Max/Min
% Normalization is required to prevent datapoints with anomalously high or low amplitude dominating the segmentation process.

% 379 = Total number of Timeslices 
% 2755 = Number of Traces 
% 100 = Number of Samples 
% timeslice = Normalized GPR timeslice data 

for i=1:379 
    time=data(i,:);
    timeslice{i}=reshape(time,  2755, 100)/max(max(data)); % Total number of traces in a profile & number of profiles in the a single volume.
end

Tmin = cellfun(@(M) min(M(:)), timeslice, 'Uniform', 0);
Tmax = cellfun(@(M) max(M(:)), timeslice, 'Uniform', 0);
Tnorm = cellfun((@(M,minM,maxM) (M-minM) ./ (maxM-minM)), timeslice, Tmin, Tmax, 'Uniform', 0);

%% 3) Data Segmentation Statistics
%% Automatic Threshold determination 
% Mean_timeslice creates a unique threshold value for each timeslice. To visualise bar chart, convert to cell format and they use bar function

% iqr_llanbedr_timeslice =
% mean_llanbedr_timeslice =
% mean_mean_llanbedr_timeslice =
% mean_timeslice_cell =
% mean_llanbedr_timeslice_cell =


for i=1:379
iqr_llanbedr_timeslice{i}=iqr(timeslice{i});
mean_llanbedr_timeslice{i}= mean(iqr_llanbedr_timeslice{i})
mean_mean_llanbedr_timeslice{i} = mean(mean_llanbedr_timeslice{i})
end

mean_timeslice_cell=mean(cell2mat(mean_mean__llanbedr_timeslice))
mean_llanbedr_timeslice_cell = cell2mat(mean_mean_timeslice)
figure;bar(mean_llanbedr_timeslice_cell)


%% 4) Data Segmentation 
% *Thresholding Filter* 
% Thresholding performs the most extensive segmentation of the GPR data, enhancing reflections of interest and suppressing superfluous data noise. 

% # BW1 = Segmented data according to automatic threshold determination. 

for i=1:379; 
BW1{i} = timeslice{i}> mean_mean_llanbedr_timeslice{i}
end 

% *Edge Detection Filter*  
% Edge detection defines the edges of features in images, while simultaneously suppressing the superfluous noise around and between them

% # BW2 = Data Segmentation according to automated Edge Detection 
% # BW3 = Data Segmentation of Threshold GPR using Edge Detection determined by automated threshold value. 
% # BW4 = Data Segmentation of raw GPR using edge detection + automated threshold value
% # BW5 = Data Segmentation of raw GPR using edge deteciton.

for i=1:379;
BW2{i} = edge(BW1{i}, 'Sobel');
BW3{i}=edge(BW1{i},'Sobel',mean_mean_llanbedr_timeslice{i})
BW4{i}=edge(timeslice{i},'Sobel',mean_mean_llanbedr_timeslice{i})
BW5{i} = edge(timeslice{i}, 'Sobel');
end 

% *Visualise the segmented GPR timeslice data*
figure,
subplot(3,2,1),imagesc(0.5*[0:100],0.04*[0:2755],BW1{200})
view(-90, -90);
xlabel('x in m')
ylabel('y in m')
set(gca,'ydir','normal')
subplot(3,2,2),imagesc(0.5*[0:100],0.04*[0:2755],BW2{200})
view(-90, -90);
set(gca,'ydir','normal')
subplot(3,2,3),imagesc(0.5*[0:100],0.04*[0:2755],BW3{200})
view(-90, -90);
set(gca,'ydir','normal')
subplot(3,2,4),imagesc(0.5*[0:100],0.04*[0:2755],BW4{200})
view(-90, -90);
set(gca,'ydir','normal')
subplot(3,2,5),imagesc(0.5*[0:100],0.04*[0:2755],BW5{200})
view(-90, -90);
set(gca,'ydir','normal')

%% 4) Data Visualization and Analysis
% *Data Analysis* 
% The segmented patterns are then overlaid on the original GPR data. This allows the user to appraise the match between the segmented data and the GPR facies and assess whether a different threshold may be required. 

for i=1:379 
SegmentationOverlay_edge{i}=imoverlay(timeslice{i}, BW2{i}, [1.0,0.4,0.0]);
SegmentationOverlay_edge_sobel{i}=imoverlay(timeslice{i}, BW3{i}, [1.0,0.4,0.0]);
SegmentationOverlay_edge_thresh_overlay{i}=imoverlay(Tnorm{i}, BW1{i}, [1.0,0.4,0.0]);
end 

figure, subplot(2,2,1),imagesc(0.5*[0:100],0.04*[0:2755],SegmentationOverlay_edge{200})
view(-90, -90);
set(gca,'ydir','normal')
subplot(2,2,2),imagesc(0.5*[0:100],0.04*[0:2755],SegmentationOverlay_edge_sobel{200})
view(-90, -90);
set(gca,'ydir','normal')
subplot(2,2,3),imagesc(0.5*[0:100],0.04*[0:2755],SegmentationOverlay_edge_thresh_overlay{200})
view(-90, -90);
set(gca,'ydir','normal')

%% 5) Time Slice Visualisation 
% *Visualisation of all 379 Segmented Timeslices*

f1=figure('NumberTitle','off','Name','GPR time slices');
set(f1,'Color',[1 1 1],'Menubar','none','Units','centimeters','Position',[1 1 40 20]);
movegui(f1,'center')

for i=1:379
subplot(1,2,1),imagesc(timeslice{i});
caxis([-0.1 0.1])
colormap parula
h = colorbar;
h.YLabel.String = 'Amplitude';
xlabel('x in m')
ylabel('y in m')
set(gca,'FontSize',16)
pause(.5)
subplot(1,2,2),imagesc(BW5{i});
h = colorbar;
h.YLabel.String = 'Amplitude';
xlabel('x in m')
ylabel('y in m')
set(gca,'FontSize',16)
pause(.5)
end 

%% For Reflectivity Core Analysis - see next script. 
