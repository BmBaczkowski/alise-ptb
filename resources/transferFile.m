function transferFile(filename, destination)

if nargin < 2
    destination = pwd;
end

fprintf('Transfering file...\n');

status = Eyelink('ReceiveFile', filename, destination, 1);

if status > 0
    fprintf('EDF file size: %.1f KB\n', status/1024); % Divide file size by 1024 to convert bytes to KB
    if exist(fullfile(destination, sprintf('%s.edf', filename)), 'file') == 2
        fprintf('Data file ''%s.edf'' can be found in ''%s''\n', filename, destination);
    else
        fprintf('Transfer cancelled\n');
    end
else
    fprintf('Empty file\n');
end
end