% US national 

clear all
close all
set(0,'DefaultAxesFontSize',14, 'defaultlinelinewidth', 2,...
    'DefaultAxesTitleFontWeight', 'normal')

% Define colormaps, note that colorbrewer was used for manuscript figures,
% and requires additional packages
bluecc = summer(6); 
autumncc = flipud(autumn(6)); 
springcc = flipud(spring(6)); 
greycc = flipud(gray(6)); 

%% Load Data - historical data 
load('NDHub.txt')
years = NDHub(:,1); % years
qinj =  NDHub(:,2); % MT - storage rate 
Q =  NDHub(:,3)./1000; % Gt - cumulative storage 

%% Input
% Growth rate fit to current data
w = 0.025318241;
% possible storage capacity required in 2100
Qinf = [30];
% Fit peak years
peak_year = [2077]; 
% Input for models with change in rate in 2030
year_rate_change = (2030);
% rate change
rtarget = [0.035137, 0.03702];
% resulting storage to meet 2100 target
Qtarget =[143.3967, 14.9725];
% resulting peak injection
peak_target = [2193.5 2122.7];
% vector defining years c5alculate model output2
x = [years(1):2150];
% calculate the constant for exponential growth
% a = Q(2030)./exp(year_Rate_change.*w);
%% Plot cumulative storage
figure('position', [105  337  1700  441])
subplot(1,3,1)
hold on

% Plot increased rate data
for i=1:length(Qtarget)
    % trajectory from 8.6 and a rate change to 10.6
    cum_at_rate_change = exp(year_rate_change.*w).*exp(-52.18353184)
    x2 = [year_rate_change:2150];
    
    C = (Qtarget(i)-cum_at_rate_change);
    pt = (C./(1+exp(rtarget(i)*(peak_target(i)-x2))));
    plot(x2,pt, 'color', autumncc(i+1,:))
end

% Plot actual data - historical growth data 
plot(years(1:end), Q(1:end),'-ok','MarkerFaceColor', 'k','MarkerSize',2, 'linewidth', 1,'HandleVisibility','off')
set(gca, 'YScale', 'log')


% Large plot axis
text(2021, 5060, 'Growth Rates', 'fontsize', 12)
axis([1982 2140 10^-2.1 10^4])
legend({[num2str(rtarget(1)*100), '%'], ...
    [num2str(rtarget(2)*100), '%']}, ...
    'Box', 'off',  'fontsize', 12, 'Position', ...
    [0.126 0.63 0.07 0.2630])
xlabel('Year')
ylabel('Cumulative storage [Gt]')
box on
set(gca, 'YScale', 'log')
set(gca, 'Color', 'white');
set(gca,'linewidth',1.5)

%% Storage rate subplot
subplot(1,3,2)
hold on



      
% Calculate rate change storage curves
for i=1:length(Qtarget)
    cum_2030 = exp(year_rate_change.*w).*exp(-52.18353184);
    x2 = [year_rate_change:2150];
    
    C = (Qtarget(i)-cum_2030);
    
    yrate2 = (C.*rtarget(i).*exp(rtarget(i).*(peak_target(i)-x2)))./...
        ((1+exp(rtarget(i).*(peak_target(i)-x2))).^2);
    
    plot(x2,yrate2, 'color', autumncc(i+1,:))
end

% Calculate inflection years
inflection_time_red = peak_target-log(2+sqrt(3))./rtarget;
C = (Qtarget-cum_2030);
y_inflect_red = (C.*rtarget.*exp(rtarget.*(peak_target-inflection_time_red)))./...
        ((1+exp(rtarget.*(peak_target-inflection_time_red))).^2);
% Label and plot inflection years  
plot(inflection_time_red, y_inflect_red, '.k', 'markersize', 12)

plot(2050, 0.032, '.r', 'markersize', 12,'HandleVisibility','off')
% Format and annotate plot
box on
xlabel('Year')
ylabel('Storage Rate [Gt/year]')
set(gca,'linewidth',1.5)
set(gca, 'Color', 'white')
axis([2031 2140 0 3.5])
set(gcf, 'Color', [1,1,1]);


text(2035, 3.45, sprintf('Storage Resource Required'), 'fontsize', 12)
legend({[num2str(round(Qtarget(1))),  ' Gt'], ...
    [num2str(round(Qtarget(2))),  ' Gt']}, ...
    'Box', 'off',  'fontsize', 12,... 
    'Position',[0.41 0.63 0.07 0.2630])
text(2100,3.45, 'North Dakota Hub', 'fontsize', 12, 'FontWeight', 'bold')
%% Now plot target tradeoff curves
subplot(1,3,3)
hold on
axis_def = [1 20 0.5 1000];
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
load('target32ND.txt')
Rr = target32ND(:,1);  % grpwth rate
M = target32ND(:,2); % Qmin
plot(Rr.*100, M, 'k', 'color', greycc(end,:))


    
for i=1:length(Qtarget)
    cum_2030 = exp(year_rate_change.*w).*exp(-52.18353184);
    C = (Qtarget(i)-cum_2030);
    plot(rtarget(i).*100,C, '.','markersize', 30, 'color', autumncc(i+1,:),'HandleVisibility','off')
end


yline(146);
yline(15);

% format plot
set(gca, 'YScale', 'log')
axis(axis_def)
box on
xlabel('Growth Rate [%]')
ylabel('Storage resource required [Gt]')
set(gca, 'Color', 'none');
set(gca,'linewidth',1.5)

text(3, 1.2, sprintf('Storage rate by 2050'), 'fontsize', 14)

legend({['32 Mt/yr, North Dakota Hub']}, ...
    'Box', 'off',  'fontsize', 13,'location', 'southwest')