
% Christopher Zahasky
% 10/9/2019
% This script is used to fit logistic models peak_year = min_peak(ifit, jfit); 
% total_stored = Qr(ifit);
% storage_rate = Rr(jfit);

%% Testing data
% Fit years
start_year = 2030;
% current growth rate
w =0.157142857;
start_q = exp(start_year.*w).*exp(-323.033061);
target_year = 2050;
target_q = [12]; %1218 2200

% range to search for equation peak
% Pr = linspace(2040, 2350, 2000);
Pr = 2040
% range to search for equation total stored
% Qr = linspace(target_q, 11000, 5000);
% Qr = [logspace(log10(target_q), log10(100), 4000)]; %, linspace(6001, 11000, 1000)];
Qr = log10(12)
% range to search for rates% 
%Rr = linspace(0.15, 0.3, 1000);
Rr = 0.242;

% preallocate
min_peak = zeros(length(Qr),1);
qt_target = zeros(length(Qr),1);
% corresponding min storage
Qmin = zeros(length(Rr),1);

for j=1
    
    for i=1
        
        for k=1
            % calculate cumulative
            qt = ((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(k)- start_year))))
            % Evaluate fit
            fit_diff(k) = (qt-start_q)^2;
        end
        [rowk] = find(fit_diff== min(fit_diff));
        
        min_peak(i) = Pr(rowk);
        % Find minium at give cumulative storage
        qt_target(i) = (target_q - ((Qr(i)-start_q)./(1+exp(Rr(j)*(Pr(rowk)- target_year)))))^2;
        
    end
    % Find minimum at given growth rate
    [ifit] = find(qt_target== min(qt_target));
    Qmin(j) = Qr(ifit)
    
end
% 
% 
% figure
% plot(Rr, Qmin, 'k')
% Rr(Qmin>10100)=[];
% Qmin(Qmin>10100)=[];
% Rr(Rr<0.1)=[];
% load('1218_target_fit')
% figure
% plot(Rr, Qmin, 'k')
hold on
% f = fit(Rr', Qmin,  'pchipinterp');
% plot( f, Rr, Qmin )
%M = movmean(Qmin,15);

%xq1 = 0.15:.001:0.3;
%p = pchip(Rr,M,xq1);
%C = xq1.';
%D = p.';
%plot(xq1,p,'-');
%T = table(C, D);
%writetable(T, 'target1.txt')

% save('3.6_2050_target_fit', 'f', 'Rr', 'Qmin')
% Now fit a function to the line

% imagesc(Rr, Qr, qt_target)
% colorbar
% caxis([0 500])
% 
% save('minimization_for_3.6_target_at2100', 'Rr', 'Qr', 'qt_target')

%[ifit, jfit] = find(qt_target== min(min(qt_target)));
peak_year = min_peak(ifit)
%inflection_time = peak_year-log(2+sqrt(3))./Rr
total_stored = Qr(ifit)
%storage_rate = Rr;
