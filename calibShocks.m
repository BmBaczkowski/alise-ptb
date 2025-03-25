function calibShocks()

% preps

sca;
clc;

% load the instrument control package
pkg load instrument-control

%% open the port
pp = parallel("/dev/parport0", 0);
pp_data(pp,0);

% print to command window
more off;

% PTB functions
ListenChar(-1); % makes it so characters typed don?t show up in the command window
KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
spaceKey = KbName('Space');
qKey = KbName('q');
% get the index for the main keyboard in the lab
KbPointer = GetKeyboardIndices('Dell Dell Wired Multimedia Keyboard');
KbQueueCreate(KbPointer); %creates cue using defaults
KbQueueStart(KbPointer);  %starts the cue
WaitSecs(.5);
KbQueueCheck(KbPointer);
KbQueueFlush(KbPointer);

fprintf('Press space to apply stimulus.\n');
fprintf('Press q to exit.\n');

shocking = 1;
dummymode_pp = 0;
while shocking
    
    KbStrokeWait(KbPointer);
    [ keyIsDown, ~, keyCode ] = KbQueueCheck(KbPointer);
    keyCode = find(keyCode, 1);
    if keyIsDown
        if keyCode == spaceKey
            sendShock(dummymode_pp, pp);
            fprintf('Stimulus\n');
            WaitSecs(.1);
        elseif keyCode == qKey
            shocking = 0;
            fprintf('Bye\n');
            WaitSecs(.5);
        end
    end
    KbQueueFlush(KbPointer);
    
end


pp_close(pp);
KbQueueStop(KbPointer);
ListenChar(0); %makes it so characters typed do show up in the command window
sca;
clear;
clc;

end

