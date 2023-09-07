% US national 

clear all
close all
set(0,'DefaultAxesFontSize',14, 'defaultlinelinewidth', 2,...
    'DefaultAxesTitleFontWeight', 'normal')

% Define colormaps, note that colorbrewer was used for manuscript figures,
% and requires additional packages
summercc = summer(6); 
autumncc = flipud(autumn(6)); 
greycc = flipud(gray(6)); 
coolcc = (cool(12)); 
%% Load Data - historical data 
load('USdata.txt')
years = USdata(:,1); % years
qinj = USdata(:,2); % MT - storage rate 
Q = USdata(:,3)./1000; % Gt - cumulative storage 
%% Load Data - Central scenario by CNP
load('CumulativeStorageCentral.txt')
years1 = CumulativeStorageCentral(:,1); % years
qinj1 = CumulativeStorageCentral(:,4); % MT - storage rate 
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
rtarget4 = [0.072, 0.07217, 0.075, 0.0761]; % Central 4 Gt
% resulting storage to meet 2100 target

Qtarget4 =[505.4473, 362.7771, 50.7197, 35.5949]; % mod 506, 366, 50.6, 36.6 - obs 505.4473, 362.7771, 50.7197, 35.5949
% resulting peak injection
peak_target4 = [2117.1, 2112.3, 2082.5, 2076.8];
% vector defining years c5alculate model output
x = [years(1):2100];
%% Plot cumulative storage
figure('position', [105  337  1700  441])
subplot(1,3,1)
hold on



for i=1:length(Qtarget4)
    % trajectory from 8.6 and a rate change to 10.6
    cum_at_rate_change = exp(year_rate_change.*w).*exp(-182.6431721);
    x2 = [year_rate_change:2100];
    
    C = (Qtarget4(i)-cum_at_rate_change);
    pt = (C./(1+exp(rtarget4(i)*(peak_target4(i)-x2))));
    plot(x2,pt, 'color', coolcc(i+1,:))
end


% Plot actual data - historical growth data 
plot(years(1:end), Q(1:end),'-ok','MarkerFaceColor', 'k','MarkerSize',2, 'linewidth', 1,'HandleVisibility','off')
set(gca, 'YScale', 'log')

% Plot 4 Gt in 2050
plot(2050, 4, '.r', 'markersize', 16,'HandleVisibility','off')

% Large plot axis
text(1972, 5000, 'Growth Rates', 'fontsize', 14)
axis([1970 2100 10^-3.4 10^4])
legend({[num2str(rtarget4(1)*100), '%, suppported by  505 Gt'], [num2str(rtarget4(2)*100), '%, supported 363 Gt'],...
     [num2str(rtarget4(3)*100), '%, supported by 51 Gt'],...
     [num2str(rtarget4(4)*100), '%, supported 36 Gt']}, ...
    'Box', 'off',  'fontsize', 12, 'Position', ...
    [0.159 0.63 0.07 0.2630])
xlabel('Year')
ylabel('Cumulative storage [Gt]')
box on
set(gca, 'YScale', 'log')
set(gca, 'Color', 'white');
set(gca,'linewidth',1.5)
text(2060,5000, 'Central', 'fontsize', 14, 'FontWeight', 'bold')
%% Storage rate subplot
subplot(1,3,2)
hold on

    
% Calculate rate change storage curves of Qtarget2
for i=1:length(Qtarget4)
    cum_2030 = exp(year_rate_change.*w).*exp(-182.6431721);
    x2 = [year_rate_change:2150];
    
    C = (Qtarget4(i)-cum_2030);
    
    yrate2 = (C.*rtarget4(i).*exp(rtarget4(i).*(peak_target4(i)-x2)))./((1+exp(rtarget4(i).*(peak_target4(i)-x2))).^2);
    
    plot(x2,yrate2, 'color', coolcc(i+1,:))
end



    % Calculate inflection years
inflection_time_red = peak_target4-log(2+sqrt(3))./rtarget4;
C = (Qtarget4-cum_2030);
y_inflect_red = (C.*rtarget4.*exp(rtarget4.*(peak_target4-inflection_time_red)))./...
        ((1+exp(rtarget4.*(peak_target4-inflection_time_red))).^2);

    
% Label and plot inflection years  

plot(inflection_time_red, y_inflect_red, '.k', 'markersize', 15)



plot(2050, 0.316, '.r', 'markersize', 16,'HandleVisibility','off')
% Format and annotate plot
box on
xlabel('Year')
ylabel('Storage Rate [Gt/year]')
set(gca,'linewidth',1.5)
set(gca, 'Color', 'white')
axis([2031 2100 0 23])
set(gcf, 'Color', [1,1,1]);


text(2032, 22.1, sprintf('Storage Resource Required'), 'fontsize', 14)
legend({
    [num2str(round(Qtarget4(1))), ' Gt'],[num2str(round(Qtarget4(2))), ' Gt'],...
    [num2str(round(Qtarget4(3))), ' Gt'],[num2str(round(Qtarget4(4))), ' Gt']}, ...
    'Box', 'off',  'fontsize', 12,... 
    'Position',[0.444 0.63 0.07 0.2630])
text(2075,22.1, 'Central scenario', 'fontsize', 14, 'FontWeight', 'bold')