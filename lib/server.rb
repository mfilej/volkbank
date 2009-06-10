class Server
  
  include Communicable
  
  attr_reader :socket
  
  def initialize(socket)
    @socket = socket
  end
  
  def dispatch
    request = Request::Parser.new(read)
    response = Bank.send(request.action, request.params)
    write(response.body)
    request.params.inspect
  end
  
end