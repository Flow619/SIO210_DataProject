%% Data Project - SIO 210
% Author: Trenton Saunders
% Date: 11/18/2023

% Description: Attempt to make animation of the ARGO Floats

close all
clear all
clc

%% Retrieve ARGO FLOAT Data
dir_string = cd;

% Open JSON File
data_string = 'C:\Users\Trenton\Desktop\SIO Courses\210\Data_Term_Project\RawData';

%% Gulf Stream DATA
cd(fullfile(data_string,'GulfStream'))

%% Gulf 1
str = fileread('argo4903233.json'); % dedicated for reading files as text 
Gulf1 = jsondecode(str);

Geolocation1 = Gulf1{1, 1}{1, 1}.geolocation.coordinates;
TimeStamp1 = datetime(Gulf1{1, 1}{1, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Gulf1{1,1})
    Geolocation1 = [Geolocation1,Gulf1{1, 1}{i, 1}.geolocation.coordinates];
    TimeStamp1 = [TimeStamp1,datetime(Gulf1{1, 1}{i, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end
%% Gulf 2
str = fileread('argo4903256.json'); % dedicated for reading files as text 
Gulf2 = jsondecode(str);


Geolocation2 = Gulf2(1).geolocation.coordinates;
TimeStamp2 = datetime(Gulf2(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Gulf2)
    Geolocation2 = [Geolocation2,Gulf2(i).geolocation.coordinates];
    TimeStamp2 = [TimeStamp2,datetime(Gulf2(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Gulf 3
str = fileread('argo3901987.json'); % dedicated for reading files as text 
Gulf3 = jsondecode(str);

Geolocation3 = Gulf3{1, 1}{1, 1}.geolocation.coordinates;
TimeStamp3 = datetime(Gulf3{1, 1}{1, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Gulf3{1,1})
    Geolocation3 = [Geolocation3,Gulf3{1, 1}{i, 1}.geolocation.coordinates];
    TimeStamp3 = [TimeStamp3,datetime(Gulf3{1, 1}{i, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Plot Gulf Stream Lat Lon Coordinates

f = figure('units','normalized','outerposition',[0 0 .6 .8])
geoplot(Geolocation1(2,:),Geolocation1(1,:),'r.','DisplayName','4903233')
hold on

geoplot(Geolocation2(2,:),Geolocation2(1,:),'r.','DisplayName','4903256')
geoplot(Geolocation3(2,:),Geolocation3(1,:),'r.','DisplayName','3901987')

geobasemap 'grayland'
geolimits([10, 50],[-105 -35])
set(gca,'fontsize',20)

%% Animation
% cd(dir_string)
% ArgoAnimation(Geolocation1(2,:),Geolocation1(1,:),Geolocation2(2,:),Geolocation2(1,:),Geolocation3(2,:),Geolocation3(1,:),data_string,"GulfStreamVideo")


%% Repeat Process Looking at Labrador Current
%% Labrador DATA
cd(fullfile(data_string,'Labrador'))

%% Labrador 1
str = fileread('argo4901798.json'); % dedicated for reading files as text 
Labrador1 = jsondecode(str);

Geolocation1_Lab = Labrador1(1).geolocation.coordinates;
TimeStamp1_Lab = datetime(Labrador1(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Labrador1)
    Geolocation1_Lab = [Geolocation1_Lab,Labrador1(i).geolocation.coordinates];
    TimeStamp1_Lab = [TimeStamp1_Lab,datetime(Labrador1(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Labrador 2
str = fileread('argo4901523.json'); % dedicated for reading files as text 
Labrador2 = jsondecode(str);

Geolocation2_Lab = Labrador2(1).geolocation.coordinates;
TimeStamp2_Lab = datetime(Labrador2(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Labrador2)
    Geolocation2_Lab = [Geolocation2_Lab,Labrador2(i).geolocation.coordinates];
    TimeStamp2_Lab = [TimeStamp2_Lab,datetime(Labrador2(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Labrador 3 
str = fileread('argo6902635.json'); % dedicated for reading files as text 
Labrador3 = jsondecode(str);

Geolocation3_Lab = Labrador3(1).geolocation.coordinates;
TimeStamp3_Lab = datetime(Labrador3(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')

for i = 2:length(Labrador3)
    Geolocation3_Lab = [Geolocation3_Lab,Labrador3(i).geolocation.coordinates];
    TimeStamp3_Lab = [TimeStamp3_Lab,datetime(Labrador3(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Update Figure
geoplot(Geolocation1_Lab(2,:),Geolocation1_Lab(1,:),'b.','DisplayName','4903233')
geoplot(Geolocation2_Lab(2,:),Geolocation2_Lab(1,:),'b.','DisplayName','4903256')
geoplot(Geolocation3_Lab(2,:),Geolocation3_Lab(1,:),'b.','DisplayName','3901987')


%% Animation
% cd(dir_string)
% ArgoAnimation(Geolocation1_Lab(2,:),Geolocation1_Lab(1,:),Geolocation2_Lab(2,:),Geolocation2_Lab(1,:),Geolocation3_Lab(2,:),Geolocation3_Lab(1,:),data_string,"LabradorVideo")

%%
cd(fullfile(data_string,'Data_Output'))
exportgraphics(f,'Gulf_Labrador_Plot.jpg')

cd(dir_string)

%% Attempt Velo Calculation
wgs84 = wgs84Ellipsoid("m");
d = distance(40.71,-74.01,48.86,2.35,wgs84)


