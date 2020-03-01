% Analysis
% Created by Patrick Wilson on 1/20/2020
% Github.com/patrickmwilson
% Created for the Elegant Mind Collaboration at UCLA 
% with Professor Katsushi Arisaka
% Copyright � 2020 Elegant Mind Collaboration. All rights reserved.

% Creates a compiled scatter plot with best fit chi-squared minimized
% lines, a compiled log10-log10 plot with a best fit line, and a scatter 
% plot and histogram of Letter height/Eccentricity for each subject 
% (divided and distribution figures).

clear variables;
close all;

% Input dialogues for subject code and date of study session
answer = inputdlg('Enter subject code:','Input');
subjectCode = char(answer(1,1));
answer = inputdlg('Enter date data was taken (mm-dd-yy):','Input');
date = char(answer(1,1));

names = ["T1", "Crowded Periphery", "Crowded Periphery Outer", ...
        "Crowded Center 9x9", "Crowded Center 3x3",  ... 
        "Isolated Character", "Anstis"];

% Checkbox input dialogue - chooses which data to analyze
global CHECKBOXES;
ButtonUI(names);

pointSlope = figure('Name','Point Slope');
logPlot = figure('Name', 'Log-Log Plot');
    
% List of plot colors and axis limits for divided and distribution figures
colors = [0 0.8 0.8; 0.9 0.3 0.9; 0.5 0 0.9; ...
        0 0.1 1; 0.4 0.8 0.5; 1 0.6 0; 0 0 0];
divLims = [45 1.5; 45 0.35; 45 0.35; 45 0.2; 45 0.2; 45 0.15; 45 0.15];

% Plots data from each experiment one at a time, producing a divided and a
% distribution figure for each experiment, and a point-slope and
% log10-log10 plot on which data from all experiments is graphed
for p = 1:length(CHECKBOXES)
    if(CHECKBOXES(p))
        name = names(p);
        table = readCsv(name);
        
        % Creates a 2 column matrix of the data. Eccentricity is placed in
        % column 1, letter height in column 2. 
        data = zeros(size(table,1),2);
        data(:,1) = table(:,3);
        % T1 data is stored differently, letter height is in column 4 of
        % the csv rather than column 2
        data(:,2) = table(:,(2 + 2*(strcmp(name,'T1'))));
        
        % Removes all rows from the data matrix which contain a zero.
        % TODO: Find a cleaner way to do this
        i = 1;
        while(i <= size(data,1))
            if(data(i,1) == 0 || data (i, 2) == 0)
                data(i,:) = [];
                continue;
            end
            i = i + 1;
        end
        
        % See makeFigs.m
        makeFigs(data, name, subjectCode, date, colors(p,:), ...
            divLims(p,:), pointSlope, logPlot);
    end
end

% Axes and text formatting for point slope plot
figure(pointSlope);
xlim([0 45]);
ylim([0 11]);
xlabel("Eccentricity (degrees)");
ylabel("Letter Height (degrees)");
title(sprintf("Letter Height vs. Retinal Eccentricity (%s %s)", ...
    subjectCode, date));
legend('show', 'Location', 'best');

% Axes and text formatting for log-log plot
figure(logPlot);
xlim([-1 2]);
ylim([-1 2]);
xlabel("Log of Eccentricity (degrees)");
ylabel("Log of Letter Height (degrees)");
title(sprintf("Log of Letter Height vs. Log of Retinal Eccentricity (%s %s)", ...
    subjectCode, date));
legend('show', 'Location', 'best');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% Saving point slope and log-log plots as png
folderName = fullfile(pwd, 'Subject_Data', subjectCode);
fileName = sprintf('%s%s', subjectCode, '_point_slope.png');
saveas(pointSlope, fullfile(folderName, fileName));
fileName = sprintf('%s%s', subjectCode, '_log_log_plot.png');
saveas(logPlot, fullfile(folderName, fileName));
