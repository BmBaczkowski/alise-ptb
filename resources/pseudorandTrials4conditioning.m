
%% Generate 20 sets of trials
% Pseudorandomization of trials
% no more than two presentations of the same condition occurred in a row

pseudorandTrials    = nan(50,20); % one column is one set

for c = 1:size(pseudorandTrials,2)
% available conditions: 
% 1- CS+UCS-; 
% 2- CS-; 
% 3- CS+UCS+;

conds           = (1:2)';
all             = nan(50,1);
%all(3:5:50)     = 3;

s1 = 0:5:20;
s2 = 25:5:45;
s = [s1 s2];
for i = 1:size(s,2)
    s(i) = s(i) + randi([1 5],1);
end
all(s)          = 3;
nanindx         = isnan(all);


val             = 1;
while val > 0
    temp        = [];
    for i = 1:20
        conds   = conds(randperm(size(conds,1)));
        temp    = [temp;conds];
    end
    all(nanindx)    = temp;
    val             = 0;
    for i = 2:size(all,1)
        if  isequal(all(i-1), all(i)) && ...
            isequal(all(i-2), all(i))
            val = val + 1;
        end
    end
end
pseudorandTrials(:,c)   = all;
end

%%
save('pseudorandTrials.mat', 'pseudorandTrials');
