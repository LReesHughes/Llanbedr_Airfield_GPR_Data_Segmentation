%% Reflectivity Core Indexing 

% Author: Luis Rees-Hughes, University of Leeds, 2020
% By considering the variation of amplitudes within a segmented region, the causes of the underlying reflectivity can be suggested – e.g., whether reflections correspond to stratigraphic, lithological or hydrological changes
% 

for k=1:379

p=0;
for i=1:size(BW2{k},1)
for j=1:size(BW2{k},2)
if BW2{k}(i, j)==1
p=p+1;
end
end
end

proportion_of_ones_BW2(k)=p/(numel(BW2{k})-(1727*27));


p=0;
for i=1:size(BW1{k},1)
for j=1:size(BW1{k},2)
if BW1{k}(i, j)==1
p=p+1;
end
end
end
proportion_of_ones_BW1(k)=p/(numel(BW2{k})-(1727*27));

end

% Core 1 

for j=1:379
    %b1 = BW5{j}; % Extacts Timeslice 279 from dataset and creates new seperate cell.
    b2_3_25 = BW4{j}(2673:2675,75:99); % Extracts rows 1217:1219 from Timeslice 279, and columns 36:60. 
    mean_b2_3_25(j)=mean(mean(b2_3_25));amp_slice{j}=zeros(size(timeslice{j}))*NaN;
    for i=1:2755
        for k=1:100
            if BW4{j}(i,k)~=0
                amp_slice{j}(i,k)=timeslice{j}(i,k);
            end
        end
    end
    %use things like nanstd(nanstd(XXX)), and nanmean(nanmean(XXX))          
    
    %b2 = b2(:, 47:49);  % Extracts columns 47:49 from Timeslice 279.
end 

figure, plot(mean_b2_3_25,0.075*0.2*0.5*[1:379])
hold on 
plot(mean_b3_3_25,0.075*0.2*0.5*[1:379], 'r')

% Core 2 

for j=1:379
    %b1 = BW1{j}; % Extacts Timeslice 279 from dataset and creates new seperate cell.
    b2_3_25 = BW4{j}(1786:1788,47:71); % Extracts rows 1217:1219 from Timeslice 279, and columns 36:60. 
    mean_b2_3_25(j)=mean(mean(b2_3_25));amp_slice{j}=zeros(size(timeslice{j}))*NaN;
    for i=1:2755
        for k=1:100
            if BW4{j}(i,k)~=0
                amp_slice{j}(i,k)=timeslice{j}(i,k);
            end
        end
    end
    %use things like nanstd(nanstd(XXX)), and nanmean(nanmean(XXX))          
    
    %b2 = b2(:, 47:49);  % Extracts columns 47:49 from Timeslice 279.
end 

% Core 3

for j=1:379
    %b1 = BW1{j}; % Extacts Timeslice 279 from dataset and creates new seperate cell.
    b2_3_25 = BW4{j}(1135:1137,47:71); % Extracts rows 1217:1219 from Timeslice 279, and columns 36:60. 
    mean_b2_3_25(j)=mean(mean(b2_3_25));amp_slice{j}=zeros(size(timeslice{j}))*NaN;
    for i=1:2755
        for k=1:100
            if BW4{j}(i,k)~=0
                amp_slice{j}(i,k)=timeslice{j}(i,k);
            end
        end
    end
    %use things like nanstd(nanstd(XXX)), and nanmean(nanmean(XXX))          
    
    %b2 = b2(:, 47:49);  % Extracts columns 47:49 from Timeslice 279.
end 

% Core 4 

for j=1:379
    %b1 = BW1{j}; % Extacts Timeslice 279 from dataset and creates new seperate cell.
    b2_3_25 = BW4{j}(620:622,55:79); % Extracts rows 1217:1219 from Timeslice 279, and columns 36:60. 
    mean_b2_3_25(j)=mean(mean(b2_3_25));amp_slice{j}=zeros(size(timeslice{j}))*NaN;
    for i=1:2755
        for k=1:100
            if BW4{j}(i,k)~=0
                amp_slice{j}(i,k)=timeslice{j}(i,k);
            end
        end
    end
    %use things like nanstd(nanstd(XXX)), and nanmean(nanmean(XXX))          
    
    %b2 = b2(:, 47:49);  % Extracts columns 47:49 from Timeslice 279.
end 

percentage_of_ones_allcores_1 = mean_b3_3_25*100
plot(percentage_of_ones_allcores_1,0.075*0.2*0.5*[1:379], 'r')


