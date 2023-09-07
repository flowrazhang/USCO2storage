% This script is used to fit logistic models peak_year = min_peak(ifit, jfit); 
% total_stored = Qr(ifit);
% growth_rate = Rr(jfit);
% Peak_Range = Pr

%% Testing data
% inputs/knowns
start_year = 2030;% t2030
start_q = 957.55/1000; % cumulative storage in 2030 = P(2030)- known 1  
start_qt = 69.84/1000; % storage rate in 2030 = Q(2030) - known 2 
target_year = 2050; % t2050
target_s = [1.04]; %storage rate in 2050 = Q(2050) i.e. 298 Mt/year in 2050 1.5Tech target - known 3 

% variables: 3 unknowns 
% range to search for equation to find tp - varaible 1 - peak year 
Pr = linspace(2050, 2350, 2000);

% range to search for equation total stored - varaible 2 - C 
Qr = [logspace(log10(1), log10(1000),4000)]; 
% range to search for rates% range of r - variable 3 growth rate 
% Rr = linspace(0.12, 0.2, 1000);
Rr = 0.138;


% preallocate
min_peak = zeros(length(Qr),1); 
qt_target = zeros(length(Qr),1);
% corresponding min storage
Qmin = zeros(length(Rr),1); % asscoiated minimum C to minimum peak year 


for j=1:length(Rr)
    
    for i=1:length(Qr)
        
            for k=1:length(Pr)
            % calculating cumulative storage        
            p = (((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(k)- start_year)))));
            % Evaluate fit between calculated and p2030 - constraint 1 
            fit_diff(k) = (p-start_q)^2; % minimum squared difference between calculated and P(2030)  
            end
        [rowk] = find(fit_diff== min(fit_diff));
        min_peak(i) = Pr(rowk); % find the minium peak year
        % Find minimum at give storage rate
        q=(Qr(i)-start_q).*Rr(j)*exp(Rr(j)*(Pr(rowk)-target_year))./((1+exp(Rr(j)*(Pr(rowk)-target_year)))^2);
        qt_target(i) = (target_s - q)^2; % minimum squared difference between calculated and Q(2030) - constraint 2
    end
    % Find minimum at given storage rate
    [ifit] = find(qt_target== min(qt_target));
    Qmin(j) = Qr(ifit);
    
end
% 
% 
% figure
%hold on
%M = movmean(Qmin,15);
%plot(Rr,Qmin,'-');
%xq1 = 0.12:.001:0.2;
%p = pchip(Rr,Qmin,xq1);
%C = xq1.';
%D = p.';
%plot(xq1,p,'-');
%T = table(C, D);
%writetable(T, 'target175.txt')

[ifit, jfit] = find(qt_target== min(min(qt_target)));
peak_year = min_peak(ifit)
%inflection_time = peak_year-log(2+sqrt(3))./Rr
total_stored = Qr(ifit)
%storage_rate = Rr;