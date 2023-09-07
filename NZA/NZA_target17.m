 % US national 

clear all
close all
set(0,'DefaultAxesFontSize',14, 'defaultlinelinewidth', 2,...
    'DefaultAxesTitleFontWeight', 'normal')

% Define colormaps, note that colorbrewer was used for manuscript figures,
% and requires additional packages
bluecc = summer(12); 
autumncc = flipud(autumn(12)); 
greycc = flipud(gray(6)); 
coolcc = (cool(12)); 
%% Load Data - historical data 
load('USdata.txt')
years = USdata(:,1); % years
qinj = USdata(:,2); % MT - storage rate 
Q = USdata(:,3)./1000; % Gt - cumulative storage 
%% Load Data - E+ scenario by NZA
load('EplusStorate.txt')
years1 = EplusStorate(:,1); % years
qinj1 = EplusStorate(:,2); % MT - storage rate 
years2 = EplusStorate(:,3); % years
qinj2 = EplusStorate(:,4); % MT - storage rate 
years3 = EplusStorate(:,5); % years
qinj3 = EplusStorate(:,6); % MT - storage rate 
%% Input
% Growth rate fit to current data
w = 0.09;
% possible storage capacity required in 2100
Qinf = [506];
% Fit peak years
peak_year = [2100]; 
% Input for models with change in rate in 2030
year_rate_change = (2030);
% rate change
% rtarget = [0.135, 0.178, 0.19]; % to meet the rate and cumulative targets of NZA
rtarget17 = [0.1462, 0.1467, 0.164 0.175];
% resulting storage to meet 2100 target

Qtarget17 =[504.7584,368.0519,50.4705 36.6516];
% resulting peak injection
peak_target17 = [2072.9, 2070.6,2054 2050.5];
% vector defining years c5alculate model output
x = [years(1):2150];
% calculate the constant for exponential growth
% a = Q(2030)./exp(year_Rate_change.*w);
%% Plot cumulative storage
figure('position', [105  337  1700  441])
subplot(1,3,1)
hold on


% Plot increased rate data
for i=1:length(Qtarget17)
    % trajectory from 8.6 and a rate change to 10.6
    cum_at_rate_change = exp(year_rate_change.*w).*exp(-182.6431721);
    x2 = [year_rate_change:2150];
    
    C = (Qtarget17(i)-cum_at_rate_change);
    pt = (C./(1+exp(rtarget17(i)*(peak_target17(i)-x2))));
    plot(x2,pt, 'color', autumncc(i+1,:))
end


% Plot actual data - historical growth data 
plot(years(1:end), Q(1:end),'-ok','MarkerFaceColor', 'k','MarkerSize',2, 'linewidth', 1,'HandleVisibility','off')
set(gca, 'YScale', 'log')


% Plot 17 Gt in 2050
plot(2050, 17, '.r', 'markersize', 15,'HandleVisibility','off')


% Large plot axis
text(1972, 5000, 'Growth Rates', 'fontsize', 14)
axis([1970 2080 10^-3.4 10^4])
legend({[num2str(rtarget17(1)*100), '%, supported by 505 Gt'], ...
    [num2str(rtarget17(2)*100), '%, supported by 368 Gt'],[num2str(rtarget17(3)*100), '%, supported by 50 Gt'],...
    [num2str(rtarget17(4)*100), '%, supported by 37 Gt']}, ...
    'Box', 'off',  'fontsize', 12, 'Position', ...
    [0.159 0.63 0.07 0.2630])
xlabel('Year')
ylabel('Cumulative storage [Gt]')
box on
set(gca, 'YScale', 'log')
set(gca, 'Color', 'white');
set(gca,'linewidth',1.5)
text(2070,5000, 'E-', 'fontsize', 14, 'FontWeight', 'bold')
%% Storage rate subplot
subplot(1,3,2)
hold on
    
% Calculate rate change storage curves of Qtarget2
for i=1:length(Qtarget17)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    x2 = [year_rate_change:2150];
    
    C = (Qtarget17(i)-cum_2030);
    
    yrate2 = (C.*rtarget17(i).*exp(rtarget17(i).*(peak_target17(i)-x2)))./...
        ((1+exp(rtarget17(i).*(peak_target17(i)-x2))).^2);
    
    plot(x2,yrate2, 'color', autumncc(i+1,:))
end

        % Calculate inflection years
inflection_time_red2 = peak_target17-log(2+sqrt(3))./rtarget17;
C = (Qtarget17-cum_2030);
y_inflect_red2 = (C.*rtarget17.*exp(rtarget17.*(peak_target17-inflection_time_red2)))./...
        ((1+exp(rtarget17.*(peak_target17-inflection_time_red2))).^2);
    
% Label and plot inflection years  
plot(inflection_time_red2, y_inflect_red2, '.k', 'markersize', 15)

plot(2050, 1.5, '.r', 'markersize', 15,'HandleVisibility','off')
plot(years2(1:end), qinj2(1:end),'--', 'color', 0.7.*[1 1 1], 'linewidth', 1.5)
% Format and annotate plot
box on
xlabel('Year')
ylabel('Storage Rate [Gt/year]')
set(gca,'linewidth',1.5)
set(gca, 'Color', 'white')
axis([2031 2080 0 23])
set(gcf, 'Color', [1,1,1]);


text(2035, 22.5, sprintf('Storage Resource Required'), 'fontsize', 12)
legend({[num2str(round(Qtarget17(1))),  ' Gt'], ...
    [num2str(round(Qtarget17(2))),  ' Gt'],[num2str(round(Qtarget17(3))), ' Gt'],...
    [num2str(round(Qtarget17(4))), ' Gt']}, ...
    'Box', 'off',  'fontsize', 12,... 
    'Position',[0.41 0.63 0.07 0.2630])
text(2065,22.5, 'Net Zero America', 'fontsize', 12, 'FontWeight', 'bold')
