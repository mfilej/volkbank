class Listener

  attr_reader :port

  def initialize(port)
    @port = port
    @server_socket = ServerSocket.new(port)
  end
  
  def listen
    Server.new(@server_socket.accept)
  end

end