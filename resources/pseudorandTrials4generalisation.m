
%% 61 trials in total = 7*8 + 5
clear;
clc;

m = nan(61,50);
for t = 1:size(m,2)
    % conditions
    % graph 1
    % CS+ 1
    % GS1 2
    % GS2 3
    % CS- 4
    % CS+UCS 0
    %
    % graph 2
    % GS1 5
    % GS2 6
    % GS3 7
    % GS4 8
    
    disp(t);
    conds = (1:8)';
    val = 1;
    while val
        val = 0;
        % random location of the shocks throughout the task
        % first presentation of each condition without the shock
        shocks = zeros(61,1);
        s = 14:10:54;
        for i = 1:size(s,2)
            s(i) = s(i) - randi([0 5],1);
        end
        shocks(s) = 1;
        
        
        
        
        trialconditions = nan(61,1);
        trialconditions(shocks==1) = 0;
        
        % first presentation of each condition
        trialconditions(conds) = randperm(size(conds,1));
        
        
        for i = 1:6
            new = randperm(size(conds,1));
            indx = find(isnan(trialconditions));
            trialconditions(indx(1:8)) = new;
        end
        % put back CS+UCS
        trialconditions_temp = trialconditions;
        trialconditions_temp(trialconditions_temp==0) = 1;
        % check if there are nearby trials of the same condition
        
        for i = 4:size(trialconditions,1)
            if val>0; continue;end
            val = val + isequal(trialconditions_temp(i),trialconditions_temp(i-3));
            val = val + isequal(trialconditions_temp(i),trialconditions_temp(i-2));
            val = val + isequal(trialconditions_temp(i),trialconditions_temp(i-1));
        end
    end
    m(:,t) = trialconditions;
end

%%
% check if all columns are unique
v = 1:50;
val = 0;
for c = 1:size(m,2)
    for d = v(v~=c)
        val = val + isequal(m(:,c),m(:,d));
    end
end

%% show the shocks
imagesc(m==0);
%%
imagesc(m);
%% save
pseudorandTrials = m;
save('pseudorandTrials4generalisation.mat', 'pseudorandTrials');
