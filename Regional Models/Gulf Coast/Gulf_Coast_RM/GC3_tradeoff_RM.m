summercc = flipud(summer(12));
autumncc = flipud(autumn(12));
wintercc = flipud(winter(12));
springcc = flipud(spring(12));
pinkcc = flipud(pink(12)); 
coolcc = (cool(12)); 
%% Input
% Growth rate fit to current data
w = 0.19;
year_rate_change = (2030);

% rate change for storage rate
rtargetGC3 = [0.1408403, 0.1409409, 0.1419419, 0.1536536]; % Gulf Coast - 769.28 Mt/year

% resulting storage - C for storage rate
QtargetGC3 = [3482.5, 1705.3, 340.1206, 36.6557]; % in Gt - 3660 1768 366 37

% resulting year of peak injection for storage rate
% peak_targetGC3 = [2095.8, 2090.7, 2078.9, 2060.6];


%% Now plot target tradeoff curves
subplot(1,3,1)
hold on
axis_def = [10 20 1 10000];
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
for i=axis_def(1):2:axis_def(2)
plot([i, i], [axis_def(3) axis_def(4)], 'linewidth', 1, 'color', line_grey,'HandleVisibility','off')
end

% load cumulative storage contours 

  load('targetGC3.txt')
  Rr = targetGC3(:,1);  % growth rate
  M = targetGC3(:,2); % Qmin
  plot(Rr.*100, M, '-', 'color', pinkcc(end-5,:))
  hold on

% plot onshore and USGS storage resource estimates 
yline(3660);
yline(1768);
yline(366);
yline(37);

    

  for i=1:length(QtargetGC3)
      cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
      C = (QtargetGC3(i)-cum_2030);
      plot(rtargetGC3(i).*100,C, '.','markersize', 30, 'color', autumncc(i+6,:),'HandleVisibility','off')
  end
% format plot
set(gca, 'YScale', 'log')
axis(axis_def)
box on
xlabel('Growth Rate [%]')
ylabel('Storage resource required [Gt]')

scatter(rtargetGC3*100,QtargetGC3,'filled')

set(gca,'linewidth',1.5)

text(13.5, 14, sprintf('Storage rate by 2050'), 'fontsize', 14)
set(gca, 'Color', 'white');
set(gcf, 'Color', 'white');

legend({['768 Mt/yr']}, ...
    'Box', 'off',  'fontsize', 13,'location', 'southwest')