class Client

  include Communicable
  
  attr_reader :host, :port
  
  def initialize(host, port)
    @host, @port = host, port
  end
  
  def connect
    @socket = Socket.new(host, port)
    if block_given?
      yield(socket)
      disconnect
    end
    self
  end
  
end