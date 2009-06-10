class Client

  include Communicable
  
  attr_reader :host, :port
  
  def initialize(host, port)
    @host, @port = host, port
  end
  
  def connect
    @socket = Socket.new(host, port)
    self
  end
  
  def request(data)
    write(data)
    response = read
    disconnect
    response
  end
  
end