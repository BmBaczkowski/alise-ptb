function sendShock(dummymode, port)

  if ~dummymode
  for i = 1:39
  pp_data(port, 128);
  WaitSecs(.002);
  pp_data(port, 0);
  WaitSecs(.003);
  end
  end  
end