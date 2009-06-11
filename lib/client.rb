class Client

  include Communicable
  include CertConfig
  
  attr_reader :host, :port, :options
  
  def initialize(host, port, options)
    @host, @port = host, port
    @options = options
    
    cert_config
  end
  
  def connect
    factory = SSLSocketFactory.get_default
    @socket = factory.create_socket(host, port)
    @socket.need_client_auth = true
    @session = @socket.get_session
    self
  end
  
  def request(data)
    write(data)
    response = read
    disconnect
    response
  end
  
end