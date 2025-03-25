function pics2nodes = get_pics2nodes(filename)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;

if isOctave
json = jsonread(filename);
else 
json = jsondecode(fileread(filename));
end
pics2nodes = nan(size(json.x1.pics2nodes,1)-1,2);   % -1 is there to remove NaN
pics2nodes(:,1) = json.x1.pics2nodes(2:end);        % graphid 1
pics2nodes(:,2) = json.x2.pics2nodes(2:end);        % graphid 2

end