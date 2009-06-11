class Listener

  include CertConfig

  attr_reader :port, :options

  def initialize(port, options)
    @port = port
    @options = options
    # @server_socket = ServerSocket.new(port)
    
    cert_config
    factory = SSLServerSocketFactory.get_default
    @server_socket = factory.create_server_socket(port)
    @server_socket.need_client_auth = true
    @server_socket.enabled_cipher_suites = cypher_suites
  end
  
  def listen
    Server.new(@server_socket.accept)
  end
  
  protected
    
  def cypher_suites
    java.lang.String[1].new.tap do |array|
      array[0] = "TLS_RSA_WITH_AES_128_CBC_SHA"
    end
  end

end