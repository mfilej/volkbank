class Server
  
  include Communicable
  
  attr_reader :port
  
  def initialize(port)
    @port = port
  end
  
  def listen
    @server_socket = ServerSocket.new(port)
    @socket = @server_socket.accept
    self
  end
  
end