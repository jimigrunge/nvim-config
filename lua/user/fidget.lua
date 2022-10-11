local status_ok, fidget = pcall(require, 'fidget')
if not status_ok then
  print 'Fidget not loaded'
	return
end

fidget.setup{}
