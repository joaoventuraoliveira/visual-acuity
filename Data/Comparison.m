clear variables;
clear all;

%PLEASE READ
%To make this script work, you must change the filepaths in the script to
%your computer, eg. if you're on a mac, and your visual-acuity folder is
%located on the desktop, you would use this for T1:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/T1/Data';
%You need to change the username in the filepath to your computer username.
%To find this on a mac, open the Terminal app, and your username will come
%before the $ symbol. To find all the spots you need to modify in this
%script, use ctrl/cmd+f and search for "folder".

%T1
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\T1\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/T1';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

tT = table2array(table);
t1 = zeros(1,15);
count = zeros(1,15);

for i = 1:size(tT,1)
    angle = tT(i, 4);
    
    if(angle == 0.23)
        angle = 1;
    elseif(angle <= 4)
        angle = (angle * 2) + 1;
    else
        angle = angle + 5;
    end
    t1(1,angle) = t1(1,angle) + tT(i, 3);
    count(1,angle) = count(1,angle) + 1;

end

t1 = t1./count;


%CROWDED CENTER 3x3
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Center 3x3\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Center 3x3';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    ccTable = readtable(filename);
    if i == 1
        cctable = ccTable;
    else
        temTable = cctable;
        cctable = [temTable; ccTable];
    end
end

ccT = table2array(cctable);
ccthree = zeros(1,7);
count = zeros(1,7);

for i = 1:size(ccT,1)
    angle = (ccT(i, 3)/5)-1;
    
    ccthree(1,angle) = ccthree(1,angle) + ccT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

ccthree = ccthree./count;

%CROWDED CENTER 11x11
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Center 11x11\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Center 11x11';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    ccTable = readtable(filename);
    if i == 1
        cctable = ccTable;
    else
        temTable = cctable;
        cctable = [temTable; ccTable];
    end
end

ccT = table2array(cctable);
cceleven = zeros(1,7);
count = zeros(1,7);

for i = 1:size(ccT,1)
    angle = (ccT(i, 3)/5)-1;
    
    cceleven(1,angle) = cceleven(1,angle) + ccT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cceleven = cceleven./count;


%CROWDED PERIPHERY
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpT = table2array(table);

cp = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpT,1)
    angle = (cpT(i,3)/5)+1;

    cp(1,angle) = cp(1,angle) + cpT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cp = cp./count;


%CROWDED PERIPHERY 5x5
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery 5x5\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery 5x5';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpfiveT = table2array(table);

cpfive = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpfiveT,1)
    angle = (cpfiveT(i,3)/5)+1;

    cpfive(1,angle) = cpfive(1,angle) + cpfiveT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cpfive = cpfive./count;

%CROWDED PERIPHERY 7x7
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery 7x7\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery 7x7';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpsevenT = table2array(table);

cpseven = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpsevenT,1)
    angle = (cpsevenT(i,3)/5)+1;

    cpseven(1,angle) = cpseven(1,angle) + cpsevenT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cpseven = cpseven./count;

%CROWDED PERIPHERY 11x11
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery 11x11\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery 11x11';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpT = table2array(table);

cpeleven = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpT,1)
    angle = (cpT(i,3)/5)+1;

    cpeleven(1,angle) = cpeleven(1,angle) + cpT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cpeleven = cpeleven./count;

%CROWDED PERIPHERY OUTER
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery Outer\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery Outer';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpouterT = table2array(table);

cpouter = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpouterT,1)
    angle = (cpouterT(i,3)/5)+1;

    cpouter(1,angle) = cpouter(1,angle) + cpouterT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cpouter = cpouter./count;

%CROWDED PERIPHERY INNER
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Crowded Periphery Inner\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Crowded Periphery Inner';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

cpinnerT = table2array(table);

cpinner = zeros(1,9);
count = zeros(1,9);

for i = 1:size(cpouterT,1)
    angle = (cpinnerT(i,3)/5)+1;

    cpinner(1,angle) = cpinner(1,angle) + cpinnerT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

cpinner = cpinner./count;

%ISOLATED CHARACTER
folder = 'C:\Users\chand\OneDrive\Desktop\Visual-Acuity\Data\Isolated Character\';
%MAC:
%folder = '/Users/YOURUSERNAME/Desktop/Visual-Acuity/Data/Isolated Character';
tfiles = dir(folder);
tfilenames={tfiles(:).name}';
tcsvfiles=tfilenames(endsWith(tfilenames,'.csv'));

for i = 1:size(tcsvfiles,1)
    filename = fullfile(folder, string(tcsvfiles(i,1)));
    tTable = readtable(filename);
    if i == 1
        table = tTable;
    else
        temTable = table;
        table = [temTable; tTable];
    end
end

icT = table2array(table);
ic = zeros(1,9);
count = zeros(1,9);

for i = 1:size(icT,1)
    angle = (icT(i,3)/5)+1;
    
    ic(1,angle) = ic(1,angle) + icT(i, 2);
    count(1,angle) = count(1,angle) + 1;
end

ic = ic./count;

anstisX = [4.02148, 8.94224, 16.2079, 17.3219, 23.249, 28.0508, 31.1738, 31.6387, 38.203, 55.2726, 55.8553];
anstisY = [0.243199, 0.377233, 0.681458, 0.839386, 1.00387, 1.34426, 1.67235, 1.17467 , 2.34074, 4.00559, 3.33797];

legends = [ "", "", "", "", "" ];
lines = [0,0,0,0,0];
txt = "%s : y = %4.2fx + %4.2f";
t1LetterHeights = [ 0.23, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5, 6, 7, 8, 9, 10 ];
letterHeights = [ 0.25, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 ];
%angles = [0, 10, 20, 30, 40];
angles = [0, 5, 10, 15, 20, 25, 30, 35, 40];
ccAngles = [10, 15, 20, 25, 30, 35, 40];

newcolor = [0.6 0.6 0.6];

%GRAPHING ANSTIS
hold on
scatter(anstisX(1,:), anstisY(1,:), 15, "k", "filled");
coefficients = [0.046,-0.031];
legends(1) = sprintf(txt, "Anstis", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(anstisX(1,:)), max(anstisX(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(1) = plot(xFit, yFit, "k-", 'LineWidth', 1);
grid on;

%GRAPHING T1
hold on
scatter(t1(1,:), t1LetterHeights(1,:), 15, "m", "filled");
coefficients = polyfit(t1(1,:), t1LetterHeights(1,:), 1);
legends(2) = sprintf(txt, "T1", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(t1(1,:)), max(t1(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(2) = plot(xFit, yFit, "m-", 'LineWidth', 1);
grid on;

%GRAPHING CROWDED CENTER
hold on
scatter(ccAngles(1,:), ccthree(1,:), 15, "c", "filled");
coefficients = polyfit(ccAngles(1,:), ccthree(1,:), 1);
legends(3) = sprintf(txt, "Crowded Center", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(ccAngles(1,:)), max(ccAngles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(3) = plot(xFit, yFit, "c-", 'LineWidth', 1);
grid on;

%GRAPHING CROWDED PERIPHERY
hold on
scatter(angles(1,:), cp(1,:), 15, "b", "filled");
coefficients = polyfit(angles(1,:), cp(1,:), 1);
legends(4) = sprintf(txt, "Crowded Periphery", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(angles(1,:)), max(angles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(4) = plot(xFit, yFit, "b-", 'LineWidth', 1);
grid on;

%GRAPHING CROWDED PERIPHERY 5x5
hold on
scatter(angles(1,:), cpfive(1,:), 15, "y", "filled");
coefficients = polyfit(angles(1,:), cpfive(1,:), 1);
legends(5) = sprintf(txt, "Crowded Periphery 5x5", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(angles(1,:)), max(angles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(5) = plot(xFit, yFit, "y-", 'LineWidth', 1);
grid on;

%GRAPHING CROWDED PERIPHERY 7x7
hold on
scatter(angles(1,:), cpseven(1,:), 15, "g", "filled");
coefficients = polyfit(angles(1,:), cpseven(1,:), 1);
legends(6) = sprintf(txt, "Crowded Periphery 7x7", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(angles(1,:)), max(angles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(6) = plot(xFit, yFit, "g-", 'LineWidth', 1);
grid on;

%GRAPHING CROWDED PERIPHERY OUTER
hold on
scatter(angles(1,:), cpouter(1,:), 15, [1 0.5 0], "filled");
coefficients = polyfit(angles(1,:), cpouter(1,:), 1);
legends(7) = sprintf(txt, "Crowded Periphery Outer", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(angles(1,:)), max(angles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(7) = plot(xFit, yFit, 'Color', [1 0.5 0], 'LineWidth', 1);
grid on;

%GRAPHING ISOLATED CHARACTER
hold on
scatter(angles(1,:), ic(1,:), 15, "r", "filled");
coefficients = polyfit(angles(1,:), ic(1,:), 1);
legends(8) = sprintf(txt, "Isolated Character", coefficients(1,1), coefficients(1,2));
xFit = linspace(min(angles(1,:)), max(angles(1,:)), 1000);
yFit = polyval(coefficients, xFit);
hold on;
lines(8) = plot(xFit, yFit, "r-", 'LineWidth', 1);
grid on;

xlim([0 inf]);
ylim([0 inf]);
xlabel("Eccentricity (degrees)");
ylabel("Letter Height (degrees)");
title("Letter Height vs. Retinal Eccentricity");

%fig.Color = [0.6 0.6 0.6];

legend([lines(1), lines(2), lines(3), lines(4), lines(5), lines(6), lines(7), lines(8)], {legends(1), legends(2), legends(3), legends(4), legends(5), legends(6), legends(7), legends(8)}, 'Location', 'best');