%% File Purpose
%This file is used to take MNIST data which has been preprocessed by
%preprocess.py and compare the NeuroModeler product to a test file for the
%given MNIST data. The data is then graphed in red and green to depict bad
%and good outputs (respectively) from NeuroModeler. 

%% How to use
%To use this file, simply put this file in the same directory as the MATLAB
%functions produced by NeuroModeler as well as the processed MNIST data.
%The only variables that need to be changed are the input values, 
%the function type selection, and the test file path. Everything else can
%be left as is, and the figure will appear after running. The amount of
%good and bad outputs from the NeuroModeler is diisplayed in the Command
%Window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Data Parameters
numInputs = 49; %Number of inputs <- Either 49, 28, or 3
numOutputs = 10; %Number of outputs <- This won't change for us

%% Change these dependent on what kind of data we're using
fortyNineInputs = 1;
twentyEightInputsColPix = 0;
twentyEightInputsColSTDDev = 0;
twentyEightRowPix = 0;
twentyEightRowSTDDev = 0;
threeInputs = 0;

testFile = importdata("convolve_7x7_test.dat", "\t");

%% Test File
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Split the file into in and outputs
input = testFile(:,[1:numInputs]);
output = testFile(:,[numInputs+1:end]);

%% Iterate and average over the inputs
avgLines = zeros([1,length(input)]);
indivadder = 0;
for i = 1:length(input)
    for j = 1:numInputs
        indivadder = indivadder + input(i,j);
    end
    avgLines(i) = indivadder/numInputs;
    indivadder = 0;
end



%% Find max of the outputs (Is it a 0-9?)
lineMaxes = zeros([1,length(output)]);
indexMaxes = lineMaxes;
lineMax = 0;
indexMax = 0;
for i = 1:length(output)
    outputLines = zeros([1,10]);
    for j = 1:numOutputs
        outputLines(j) = output(i,j);
    end
    [lineMaxes(i), indexMaxes(i)] = max(outputLines);
end

%% Find # with most occurrences
mostOccurrences = mode(indexMaxes);
numOccurrences = sum(indexMaxes == mostOccurrences);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NeuroModeler
neuroOutput = zeros([length(input),numOutputs]);

%Go into one of these depending on what flag was set at the top
%For loop iterates over the input file
if(fortyNineInputs == 1)
    for i = 1:length(input)
        neuroOutput(i,:) = fortyNine(input(i,:));
    end 
end

if(twentyEightInputsColPix == 1)
    for i = 1:length(input)
        neuroOutput(i,:) = twentyEightColPix(input(i,:));
    end 
end

if(twentyEightInputsColSTDDev == 1)
    for i = 1:length(input)
        neuroOutput(i,:) = twentyEightColSTDDev(input(i,:));
    end 
end

if(twentyEightRowPix == 1)
   for i = 1:length(input)
        neuroOutput(i,:) = twentyEightRowPix(input(i,:));
    end 
end

if(twentyEightRowSTDDev == 1)
    for i = 1:length(input)
        neuroOutput(i,:) = twentyEightRowSTDDevInputs(input(i,:));
    end 
end

if(threeInputs == 1)
    for i = 1:length(input)
        neuroOutput(i,:) = three(input(i,:));
    end   

end

%% Find max of NeuroModeler Outputs
neuroMaxes = zeros([1,length(output)]);
neuroIndexes = neuroMaxes;
for i = 1:length(output)
    outputLines = zeros([1,10]);
    for j = 1:numOutputs
        outputLines(j) = neuroOutput(i,j);
    end
    [neuroMaxes(i), neuroIndexes(i)] = max(outputLines);
    neuroIndexes(i) = neuroIndexes(i) - 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compare NeuroModeler with Test File
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
goodAverage = [];
goodIndexes = [];
goodOccurences = [];
badAverage = [];
badIndexes = [];
badOccurences = [];

%Use these to count up how well the NeuroModeler matches the test file
%(These should add up to 10,000 since that's how big our standard test file
%is
numBad = 0;
numGood = 0;

for i = 1:length(neuroIndexes)
    if indexMaxes(i) ~= neuroIndexes(i)
        badAverage = [badAverage, avgLines(i)];
        badIndexes = [badIndexes, neuroIndexes(i)];
        badOccurences = [badOccurences, i];
        numBad = numBad + 1;

    else
        goodAverage = [goodAverage, avgLines(i)];
        goodIndexes = [goodIndexes, neuroIndexes(i)];
        goodOccurences = [goodOccurences, i];
        numGood = numGood + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Plot depending on the selection at the top. Scatters were used since the
%axes are not the same length
if(fortyNineInputs == 1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File for 49 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");
end

if(twentyEightInputsColPix == 1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File Bright Pixels in Each Column for 28 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");
end

if(twentyEightInputsColSTDDev == 1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File Standard Deviation in Each Column for 28 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");
end

if(twentyEightRowPix == 1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File Bright Pixels in Each Row for 28 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");
end

if(twentyEightRowSTDDev == 1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File Standard Deviation in Each Row for 28 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");
end

if(threeInputs == 1)
    figure(1)
    scatter3(goodAverage, goodOccurences, goodIndexes, 30, 'green', 'filled');
    hold on;
    scatter3(badAverage, badOccurences, badIndexes, 15, 'red', 'filled');
    hold off;
    xlabel('Average of the NeuroModel Output');
    ylabel('Number of Occurrences');
    zlabel("Numbers");
    grid on;
    title("NeuroModel Output vs. Test File For 3 Inputs");
    legend("Correct Output", "Incorrect Output");
    fprintf("Number of Good Outputs: %d", numGood);
    fprintf("\n");
    fprintf("Number of Bad Outouts: %d", numBad);
    fprintf("\n");

    %% Store each individual number for a different corresponding color
    zeroVector = [];
    oneVector = [];
    twoVector = [];
    threeVector = [];
    fourVector = [];
    fiveVector = [];
    sixVector = [];
    sevenVector = [];
    eightVector = [];
    nineVector = [];
    for i = 1:length(input)
        if (neuroIndexes(i) == 0)
            zeroVector = [zeroVector; input(i,:)];
        end
        if (neuroIndexes(i) == 1)
            oneVector = [oneVector; input(i,:)];
        end
        if (neuroIndexes(i) == 2)
            twoVector = [twoVector; input(i,:)];
        end
        if (neuroIndexes(i) == 3)
            threeVector = [threeVector; input(i,:)];
        end
        if (neuroIndexes(i) == 4)
            fourVector = [fourVector; input(i,:)];
        end
        if (neuroIndexes(i) == 5)
            fiveVector = [fiveVector; input(i,:)];
        end
        if (neuroIndexes(i) == 6)
            sixVector = [sixVector; input(i,:)];
        end
        if (neuroIndexes(i) == 7)
            sevenVector = [sevenVector; input(i,:)];
        end
        if (neuroIndexes(i) == 8)
            eightVector = [eightVector; input(i,:)];
        end
        if (neuroIndexes(i) == 9)
            nineVector = [nineVector; input(i,:)];
        end
    end


    figure(2)
    scatter3(zeroVector(:, 2), zeroVector(:,3), zeroVector(:,1), 15, 'red', 'filled');
    hold on;
    scatter3(oneVector(:, 2), oneVector(:, 3), oneVector(:, 1), 15, 'green', 'filled');
    hold off;
    hold on;
    scatter3(twoVector(:, 2), twoVector(:, 3), twoVector(:, 1), 15, 'blue', 'filled');
    hold off;
    hold on;
    scatter3(threeVector(:, 2), threeVector(:, 3), threeVector(:, 1), 15, 'yellow', 'filled');
    hold off;
    hold on;
    scatter3(fourVector(:, 2), fourVector(:, 3), fourVector(:, 1), 15, 'cyan', 'filled');    
    hold off;
    hold on;
    scatter3(fiveVector(:, 2), fiveVector(:, 3), fiveVector(:, 1), 15, 'magenta', 'filled');    
    hold off;
    hold on;
    scatter3(sixVector(:, 2), sixVector(:, 3), sixVector(:, 1), 15, 'black', 'filled');
    hold off;
    hold on;
    scatter3(sevenVector(:, 2), sevenVector(:, 3), sevenVector(:, 1), 15, 'white', 'filled');
    hold off;
    hold on;
    scatter3(eightVector(:, 2), eightVector(:, 3), eightVector(:, 1), 15, [0.6350 0.0780 0.1840], 'filled');
    hold off;
    hold on;
    scatter3(nineVector(:, 2), nineVector(:, 3), nineVector(:, 1), 15, [.9290 .6940 .1250], 'filled');
    hold off;
    xlabel('Average Row Standard Deviation');
    ylabel('Average Column Standard Deviation');
    zlabel("Total Amount of Bright Pixels");
    grid on;
    title("NeuroModel Output vs. Test File For 3 Inputs");
    legend("Zeros", "Ones", "Twos", "Threes", "Fours", "Fives", "Sixes", "Sevens", "Eights", "Nines");
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%