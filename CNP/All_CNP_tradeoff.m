summercc = (summer(12));
autumncc = (autumn(12));
wintercc = flipud(winter(12));
springcc = (spring(12));
pinkcc = flipud(pink(12)); 
coolcc = (cool(12)); 
%% Input
% Growth rate fit to current data
w = 0.09;
year_rate_change = (2030);

% rate change for cumulative storage
rtarget4 = [0.072, 0.07217, 0.075, 0.0761]; % Central 4 Gt
rtarget5 = [0.087546, 0.088, 0.0925, 0.09472]; % Delayed Electrification & Low land 5.5 Gt
rtarget4z = [0.080169, 0.080225, 0.0836, 0.0851]; % Net negative 4.7 Gt

% rate change for storage rate
rtarget316 = [0.075037, 0.07516, 0.07943, 0.0818]; % central 316 Mt/y
rtarget380 = [0.08055, 0.080744, 0.0862, 0.08863]; % Delayed Electrification 380 Mt/y
rtarget680 = [0.099612, 0.09973, 0.1088, 0.114]; % Low land 680 Mt/y
rtarget465 = [0.08698, 0.087295, 0.0935, 0.097]; % Net negative 465 Mt/y

% resulting storage - C for cumulative storage
Qtarget4 =[505.4473, 362.7771, 50.7197, 35.5949]; % mod 506, 366, 50.6, 36.6 - obs 505.4473, 362.7771, 50.7197, 35.5949
Qtarget5 =[501.9670, 362.1510, 50.8073, 36.4662]; % mod 506, 366, 50.6, 36.6 - obs 497.6503, 350.4581, 50.8073, 36.8461
Qtarget4z =[500.2358, 360.2792, 50.8073, 36.0902]; % mod 506, 366, 50.6, 36.6 - obs 500.2358, 360.2792, 50.8073, 36.0902


% resulting storage - C for storage rate
Qtarget316 = [503.7042, 355.9491, 50.3704, 36.6557]; % central 316 Mt/y
Qtarget380 = [505.4473, 366.5566, 50.0236, 36.0279]; % Delayed Electrification 380 Mt/y
Qtarget680 = [503.7042,  364.0326, 50.9832, 36.4033]; % Low land 680 Mt/y
Qtarget465 = [505.4473,  363.4043, 50.8073, 35.6564]; % Net negative 465 Mt/y

% resulting year of peak injection for cumulative storage 
% peak_target4 = [2117.1, 2112.3, 2082.5, 2076.8];
% peak_target5 = [2100.9, 2096.9, 2072.6, 2068.1];
% peak_target4z = [2108.1, 2103.9, 2077.1, 2071.9];
% peak_target2 =[2350, 2350, 2350, 2350];

% resulting year of peak injection for storage rate
% peak_target316 = [2113.7, 2108.7, 2079.4, 2074];
% peak_target380 = [2107.9, 2103, 2075.5, 2070.6];
% peak_target680 = [2092.9, 2089, 2066.2, 2061.4];
% peak_target465 = [2101.9, 2098, 2072.1, 2066.7];
% peak_target240 = [2123.6, 2118.6, 2085.7, 2080];


%% Now plot target tradeoff curves
subplot(1,3,1)
hold on
axis_def = [0 20 1 10000];
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
load('target4.txt')
Rr = target4(:,1);  % growth rate
M = target4(:,2); % Qmin
plot(Rr.*100, M, '--', 'color', pinkcc(end,:))
hold on
load('target5.txt')
Rr = target5(:,1);  % growth rate
M = target5(:,2); % Qmin
plot(Rr.*100, M, '--', 'color', pinkcc(end-1,:))
hold on
load('target4z.txt')
Rr = target4z(:,1);  % growth rate
M = target4z(:,2); % Qmin
plot(Rr.*100, M, '--', 'color', pinkcc(end-2,:))
hold on

load('target316.txt')
Rr = target316(:,1);  % growth rate
M = target316(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', pinkcc(end-3,:))
hold on
load('target380.txt')
Rr = target380(:,1);  % growth rate
M = target380(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', pinkcc(end-4,:))
hold on
load('target680.txt')
Rr = target680(:,1);  % growth rate
M = target680(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', pinkcc(end-5,:))
hold on
load('target465.txt')
Rr = target465(:,1);  % growth rate
M = target465(:,2); % Qmin
plot(Rr.*100, M, '-', 'color', pinkcc(end-6,:))
hold on

% plot onshore and USGS storage resource estimates 
yline(366);
yline(506);
yline(36.6);
yline(50.6);

    

for i=1:length(Qtarget4)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget4(i)-cum_2030);
    plot(rtarget4(i).*100,C, '.','markersize', 30, 'color', coolcc(i+1,:),'HandleVisibility','off')
end

for i=1:length(Qtarget5)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget5(i)-cum_2030);
    plot(rtarget5(i).*100,C, '.','markersize', 30, 'color', summercc(i+1,:),'HandleVisibility','off')
end
for i=1:length(Qtarget4z)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget4z(i)-cum_2030);
    plot(rtarget4z(i).*100,C, '.','markersize', 30, 'color', autumncc(i+1,:),'HandleVisibility','off')
end

for i=1:length(Qtarget316)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget316(i)-cum_2030);
    plot(rtarget316(i).*100,C, '.','markersize', 30, 'color', coolcc(i+5,:),'HandleVisibility','off')
end
for i=1:length(Qtarget380)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget380(i)-cum_2030);
    plot(rtarget380(i).*100,C, '.','markersize', 30, 'color', summercc(i+5,:),'HandleVisibility','off')
end
for i=1:length(Qtarget680)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget680(i)-cum_2030);
    plot(rtarget680(i).*100,C, '.','markersize', 30, 'color', springcc(i+5,:),'HandleVisibility','off')
end
for i=1:length(Qtarget465)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    C = (Qtarget465(i)-cum_2030);
    plot(rtarget465(i).*100,C, '.','markersize', 30, 'color', autumncc(i+5,:),'HandleVisibility','off')
end

% format plot
set(gca, 'YScale', 'log')
axis(axis_def)
box on
xlabel('Growth Rate [%]')
ylabel('Storage resource required [Gt]')

set(gca,'linewidth',1.5)

text(5.1, 4, sprintf('Cumulative storage by 2050'), 'fontsize', 14)
text(13.5, 4, sprintf('Storage rate by 2050'), 'fontsize', 14)
set(gca, 'Color', 'white');
set(gcf, 'Color', 'white');

legend({['4 Gt'],['5.5 Gt'], ['4.7 Gt'],['316 Mt/yr'],['380 Mt/yr'],['680 Mt/yr'],['465 Mt/yr']}, ...
    'Box', 'off',  'fontsize', 13,'location', 'southwest')