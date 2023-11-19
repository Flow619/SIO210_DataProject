%% Data Project - SIO 210
% Author: Trenton Saunders
% Date: 11/18/2023

% Description: Code for ARGO float SIO 210 Final Project.

close all
clear all
clc

%%
dir_string = cd;

% file with JSON files (ARGO data)
data_string = 'C:\Users\Trenton\Desktop\SIO Courses\210\Data_Term_Project\RawData';

%% Gulf Stream DATA
cd(fullfile(data_string,'GulfStream'))

%% Gulf 1
str = fileread('argo4903233.json');
Gulf1 = jsondecode(str);

Geolocation1 = Gulf1{1, 1}{1, 1}.geolocation.coordinates;    % Lat Lon Data
TimeStamp1 = datetime(Gulf1{1, 1}{1, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');  % Time Data

for i = 2:length(Gulf1{1,1})    % retrieve full array
    Geolocation1 = [Geolocation1,Gulf1{1, 1}{i, 1}.geolocation.coordinates];
    TimeStamp1 = [TimeStamp1,datetime(Gulf1{1, 1}{i, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

% Remove bad data
Geolocation1(:,145) = [];  % Bad Lat Lon Data
TimeStamp1(145) = [];
%% Gulf 2
str = fileread('argo4903256.json');
Gulf2 = jsondecode(str);

Geolocation2 = Gulf2(1).geolocation.coordinates;
TimeStamp2 = datetime(Gulf2(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');

for i = 2:length(Gulf2)
    Geolocation2 = [Geolocation2,Gulf2(i).geolocation.coordinates];
    TimeStamp2 = [TimeStamp2,datetime(Gulf2(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Gulf 3
str = fileread('argo3901987.json'); % dedicated for reading files as text 
Gulf3 = jsondecode(str);

Geolocation3 = Gulf3{1, 1}{1, 1}.geolocation.coordinates;
TimeStamp3 = datetime(Gulf3{1, 1}{1, 1}.timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');

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

%% --Repeat Process Looking at Labrador Current--

%% Labrador Data file
cd(fullfile(data_string,'Labrador'))

%% Labrador 1
str = fileread('argo4901798.json');
Labrador1 = jsondecode(str);

Geolocation1_Lab = Labrador1(1).geolocation.coordinates;
TimeStamp1_Lab = datetime(Labrador1(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');

for i = 2:length(Labrador1)
    Geolocation1_Lab = [Geolocation1_Lab,Labrador1(i).geolocation.coordinates];
    TimeStamp1_Lab = [TimeStamp1_Lab,datetime(Labrador1(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Labrador 2
str = fileread('argo4901523.json');
Labrador2 = jsondecode(str);

Geolocation2_Lab = Labrador2(1).geolocation.coordinates;
TimeStamp2_Lab = datetime(Labrador2(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');

for i = 2:length(Labrador2)
    Geolocation2_Lab = [Geolocation2_Lab,Labrador2(i).geolocation.coordinates];
    TimeStamp2_Lab = [TimeStamp2_Lab,datetime(Labrador2(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Labrador 3 
str = fileread('argo6902635.json');
Labrador3 = jsondecode(str);

Geolocation3_Lab = Labrador3(1).geolocation.coordinates;
TimeStamp3_Lab = datetime(Labrador3(1).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z');

for i = 2:length(Labrador3)
    Geolocation3_Lab = [Geolocation3_Lab,Labrador3(i).geolocation.coordinates];
    TimeStamp3_Lab = [TimeStamp3_Lab,datetime(Labrador3(i).timestamp,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSS''Z')];
end

%% Update Lat Lon Figure
geoplot(Geolocation1_Lab(2,:),Geolocation1_Lab(1,:),'b.','DisplayName','')
geoplot(Geolocation2_Lab(2,:),Geolocation2_Lab(1,:),'b.','DisplayName','')
geoplot(Geolocation3_Lab(2,:),Geolocation3_Lab(1,:),'b.','DisplayName','')


%% Animation
% cd(dir_string)
% ArgoAnimation(Geolocation1_Lab(2,:),Geolocation1_Lab(1,:),Geolocation2_Lab(2,:),Geolocation2_Lab(1,:),Geolocation3_Lab(2,:),Geolocation3_Lab(1,:),data_string,"LabradorVideo")

%% Save Figure
cd(fullfile(data_string,'Data_Output'))
exportgraphics(f,'Gulf_Labrador_Plot.jpg')

%% Attempt Velo Calculation (Data Flipped!)
cd(dir_string) % Change Directory

g = figure('units','normalized','outerposition',[0 0 .6 .8]);
[VeloTable.Gulf1,g] = ArgoVelocityFunction(TimeStamp1,Geolocation1,g);
hold on
[VeloTable.Gulf2,g] = ArgoVelocityFunction(TimeStamp2,Geolocation2,g);
[VeloTable.Gulf3,g] = ArgoVelocityFunction(TimeStamp3,Geolocation3,g);
[VeloTable.Lab1,g] = ArgoVelocityFunction(TimeStamp1_Lab,Geolocation1_Lab,g);
[VeloTable.Lab2,g] = ArgoVelocityFunction(TimeStamp2_Lab,Geolocation2_Lab,g);
[VeloTable.Lab3,g] = ArgoVelocityFunction(TimeStamp3_Lab,Geolocation3_Lab,g);

geobasemap 'grayland'
geolimits([10, 50],[-105 -35])
set(gca,'fontsize',20)

c = colorbar;
colormap 'jet'
clim([0,0.6])
c.Label.String = 'Speed [m/s]';

%% Save Figure
cd(fullfile(data_string,'Data_Output'))
exportgraphics(g,'Gulf_Labrador_Velocity_Plot.jpg')

%%
cd(dir_string)