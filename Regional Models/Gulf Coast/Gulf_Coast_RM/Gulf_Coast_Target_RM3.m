% This script is used to fit logistic models peak_year = min_peak(ifit, jfit); 
% total_stored = Qr(ifit);
% growth_rate = Rr(jfit);
% Peak_Range = Pr

%% Testing data
% inputs/knowns
start_year = 2030;% t2030
% current growth rate
w =0.19194411;
start_q = 0.33083; % cumulative storage in 2030 = P(2030)-> known 1  
start_qt = 38.12/1000; % storage rate in 2030 = Q(2030) in Gt -> known 2 
target_year = 2050; % t2050
target_s = [769.28/1000]; %storage rate in 2050 = Q(2050) i.e. 769.28 Mt/year in 2050 for Gulf Coast Hub 2 -> known 3 
%  target_q = [unknown]; %cumulative storgage in 2050

% variables: 4 unknowns 
% range to search for equation to find tp - variable 1 -> peak year 
Pr = linspace(2040, 2350, 2000);
% range to search for equation total stored - variable 2 -> C 
Qr = [logspace(log10(1), log10(10000), 4000)]; %, linspace(6001, 11000, 1000)];
% range to search for rates% range of r -> variable 3 growth rate 
%   Rr = linspace(0.1, 0.2, 1000);
  Rr = 0.1536536;


% preallocate
min_peak = zeros(length(Qr),1); % minimum peak year found using the minimisation function between calculated and true data
qt_target = zeros(length(Qr),1);
% corresponding min storage
Qmin = zeros(length(Rr),1); % associated minimum C to minimum peak year 


for j=1:length(Rr)
    
    for i=1:length(Qr)
        
            for k=1:length(Pr)
            % calculate storage rate at 2030           
             p = ((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(k)- start_year))));
            
             % calculate cumulative storage
%             qt = ((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(k)- start_year))));
            
            % Evaluate fit for p (storage rate)
             fit_diff(k) = (p-start_q)^2; % minimum squared difference between calculated and Q(2030)  
            
            % Evaluate fit for qt (cumulative storage)
%             fit_diff(k) = (qt-start_q)^2;
            end
             [rowk] = find(fit_diff== min(fit_diff));
        min_peak(i) = Pr(rowk); % find the minimum peak year
        
        % Find minimum at given storage rate 
         qt_target(i) = (target_s - ((Qr(i)-start_q).*Rr(j)*exp(Rr(j)*(Pr(rowk)-target_year))/(1+exp(Rr(j)*(Pr(rowk)-target_year)))^2))^2;
        
        % Find minium at given cumulative storage
%         qt_target(i) = (target_q - ((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(rowk)- target_year)))))^2;
        
    end
    % Find minimum at given storage rate
    [ifit] = find(qt_target== min(qt_target));
    Qmin(j) = Qr(ifit);
    
end
% 
% 
%     figure
%    hold on
%    M = movmean(Qmin,10);
%    plot(Rr,Qmin,'-');
%    xq1 = 0.1:0.0001001:0.2;
%    p = pchip(Rr,M,xq1);
%    C = xq1.';
%    D = p.';
%    plot(xq1,p,'-');
%    T = table(C, D);
%    writetable(T, 'targetGC3.txt')


 [ifit, jfit] = find(qt_target== min(min(qt_target)));
 peak_year = min_peak(ifit)
%inflection_time = peak_year-log(2+sqrt(3))./Rr
 total_stored = Qr(ifit)
%storage_rate = Rr;