function [] = ArgoAnimation(Geo1_lat,Geo1_lon,Geo2_lat,Geo2_lon,Geo3_lat,Geo3_lon,data_string,AnimationName)

cd(fullfile(data_string,'Data_Output'))
v = VideoWriter(strcat(AnimationName,".avi"));
v.FrameRate = 60;

if strcmp(AnimationName,'LabradorVideo')
    v.FrameRate = 45;
end
    
open(v)

figure('units','normalized','outerposition',[0 0 .6 .8])
geoplot(Geo1_lat(end),Geo1_lon(end),'.b')
hold on
geobasemap 'grayland'
geolimits([10, 50],[-105 -35])
set(gca,'fontsize',20)

for i = length(Geo1_lat)-1:-1:1
geoplot(Geo1_lat(i),Geo1_lon(i),'.b')
frame = getframe(gcf);
writeVideo(v,frame)
end

for j = length(Geo2_lat):-1:1
geoplot(Geo2_lat(j),Geo2_lon(j),'.r')
frame = getframe(gcf);
writeVideo(v,frame)
end

for k = length(Geo3_lat):-1:1
geoplot(Geo3_lat(k),Geo3_lon(k),'.g')
frame = getframe(gcf);
writeVideo(v,frame)
end

close(v)

end



