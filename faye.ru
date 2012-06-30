require 'faye'

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.listen(9292)
