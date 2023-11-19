function [VeloTable,fig] = ArgoVelocityFunction(TimeStamp,Geolocation,fig)
% Author: Trenton Saunders
% Date: 11/18/2023
% Description: Attempt to calculate velocity with Argo Data

%% Re-orient Data
timeflip = flipud(TimeStamp');  % flip up (Oldest Data Start the array)
temp1 = flipud(fliplr(Geolocation')); 
temp2 = flipud(fliplr(Geolocation'));

%% Calulate dx
cd('C:\Users\Trenton\Documents\GitHub\SIO210_DataProject')
[d1km ~] = lldistkm(temp1(1:end-1,:),temp2(2:end,:));  % dist between consecutive lat lon points (km)

%% Speed Estimate
velocity = (d1km*1000) ./ seconds(diff(timeflip));  %% [m/s]

averagelat = mean([temp1(1:end-1,1),temp2(2:end,1)],2);
averagelon = mean([temp1(1:end-1,2),temp2(2:end,2)],2);

%% Table
VeloTable = array2table([averagelat,averagelon,velocity],'VariableNames',{'lat','lon','velo'});

%% Plot
figure(fig)
s = geoscatter(VeloTable,"lat","lon","filled");
s.ColorVariable = "velo";

end