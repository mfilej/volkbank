class Server
  
  include Communicable
  
  attr_reader :socket
  
  def initialize(socket)
    @socket = socket
  end
  
  def client_name
    socket.session.peer_principal.name.match(/CN=(.+)/)[1]
  end
  
  def dispatch
    request = Request::Parser.new(read)
    response = Bank.send(request.action, request.params.update(:name => client_name))
    write(response.body)
    request
  end
  
end