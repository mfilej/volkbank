class Server
  
  include Communicable
  
  attr_reader :socket
  
  def initialize(socket)
    @socket = socket
  end
  
end