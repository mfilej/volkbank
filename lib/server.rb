class Server
  
  include Communicable
  
  attr_reader :socket
  
  def initialize(socket)
    @socket = socket
  end
  
  def dispatch
    request = Request::Parser.new(read)
    account = Bank.send(request.action, request.params)
  end
  
end