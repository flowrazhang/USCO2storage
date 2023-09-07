summercc = flipud(summer(12));
autumncc = flipud(autumn(12)); 
greycc = flipud(gray(7)); 
coolcc = (cool(12)); 
springcc = flipud(spring(12)); 
%% Input
% Growth rate fit to current data
w = 0.09;
year_rate_change = (2030);
% rate change
rtargetMD = [0.13857, 0.152];% growth rate modelled 
rtargetND = [0.035137, 0.03702];
rtargetCa = [0.1728, 0.173, 0.183];
rtargetGC = [0.132361, 0.13374  0.1441];
% resulting storage to meet 2100 target
QtargetMD = [152.2459, 11.9473];% storage resource modelled 
QtargetND =[143.3967, 14.9725];
QtargetCa = [90.4668, 29.1989, 2.9588];
QtargetGC =[1761.2, 353.7017   36.4242];
%% Now plot target tradeoff curves
subplot(1,3,1)
hold on
axis_def = [1 20 0.03 10000];
line_grey = ones(1,3).*0.9;
for i=1:1:10
plot([axis_def(1)+0.1, axis_def(2)-0.1], [i i], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end
for i=10:10:101
plot([axis_def(1)+0.1, axis_def(2)-0.1], [i i], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end
for i=100:100:1000
plot([axis_def(1)+0.1, axis_def(2)-0.1], [i i], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end
for i=1000:1000:10000
plot([axis_def(1)+0.1, axis_def(2)-0.1], [i i], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end
for i=axis_def(1):5:axis_def(2)
plot([i, i], [axis_def(3) axis_def(4)], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end

% load cumulative storage contours
load('target32.txt')
Rr = target32(:,1);  % grpwth rate
M = target32(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', greycc(end,:))
hold on
load('target265.txt')
Rr = target265(:,1);  % grpwth rate
M = target265(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', greycc(end-3,:))
hold on
load('target674.txt')
Rr = target674(:,1);  % grpwth rate
M = target674(:,2); % Qmin
plot(Rr.*100, M, 'k', 'color', greycc(end-4,:))
hold on
load('target63.txt')
Rr = target63(:,1);  % grpwth rate
M = target63(:,2); % Qmin
plot(Rr.*100, M, 'k', 'color', greycc(end-5,:))
hold on


% plot onshore and USGS storage resource estimates 
yline(154);
yline(12);

yline(15);

yline(30);
yline(90);
yline(3);


yline(1767)
yline(366)
yline(37)

for i=1:length(QtargetMD)
    cum_2030 = exp(year_rate_change.*0.298256012).*exp(-607.1355483);
    C = (QtargetMD(i)-cum_2030);
    plot(rtargetMD(i).*100,C, '.','markersize', 30, 'color', coolcc(i+1,:),'HandleVisibility','off')
end

for i=1:length(QtargetND)
    cum_2030 = exp(year_rate_change.*0.025464353).*exp(-52.47182071);
    C = (QtargetND(i)-cum_2030);
    plot(rtargetND(i).*100,C, '.','markersize', 30, 'color', springcc(i+6,:),'HandleVisibility','off')
end
for i=1:length(QtargetCa)
    cum_2030 = exp(year_rate_change.*0.038).*exp(-81.779792);
    C = (QtargetCa(i)-cum_2030);
    plot(rtargetCa(i).*100,C, '.','markersize', 30, 'color', summercc(i+1,:),'HandleVisibility','off')
end
for i=1:length(QtargetGC)
    cum_2030 = exp(year_rate_change.* 0.192159471).*exp(-391.2386552);
    C = (QtargetGC(i)-cum_2030);
    plot(rtargetGC(i).*100,C, '.','markersize', 30, 'color', autumncc(i+1,:),'HandleVisibility','off')
end

% format plot
set(gca, 'YScale', 'log')
axis(axis_def)
box on
xlabel('Growth Rate [%]')
ylabel('Storage resource required [Gt]')

set(gca,'linewidth',1.5)

text(1.3, 0.5, sprintf('Storage rate by 2050'), 'fontsize', 14)
set(gca, 'Color', 'white');
set(gcf, 'Color', 'white');

legend({['32 Mt/yr, North Dakota Hub'],['265 Mt/yr, Mideastern Hub'],['674 Mt/yr, Gulf Coast Hub'],['63 Mt/yr, California Hub']}, ...
    'Box', 'off',  'fontsize', 13,'location', 'southwest')