input_count = 1; %How many statistics? Change in tandem with preprocess.py
output_count = 1; %Should remain as 1?

%Import data (either make a symlink or put the files in the same location as script)
data_train = importdata("stat_train.dat", " ");
data_test = importdata("stat_test.dat", " ");

train_stats = {};

for i = 1:length(data_train(:, 1))
    if(data_train(i, end)) == 1
        train_stats{end+1, 1} = [data_train(i, 1)
                                 data_train(i, 2)];
    end
end

%train_stats = cell2mat(train_stats); %Convert cells to normal arrays
