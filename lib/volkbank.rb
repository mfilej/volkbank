require 'java'
require 'stringio'
require 'rubygems'
require 'builder'
require 'nokogiri'

include_class java.net.Socket
include_class java.net.ServerSocket

include_class java.io.PrintWriter
include_class java.io.BufferedReader
include_class java.io.InputStreamReader

include_class java.security.KeyStore;
include_class java.security.SecureRandom;

include_class javax.net.ssl.KeyManagerFactory;
include_class javax.net.ssl.SSLContext;
include_class javax.net.ssl.SSLSocket;
include_class javax.net.ssl.SSLSocketFactory;
include_class javax.net.ssl.SSLServerSocket;
include_class javax.net.ssl.SSLServerSocketFactory;
include_class javax.net.ssl.TrustManagerFactory;


%w{ core_ext
    cert_config
    communicable listener server client
    request
      request/parser
    response
      response/parser
    bank
      bank/account
  }.each { |lib| require(lib) }

def srv
  Listener.new(4567).listen
end

def cli
  Client.new('localhost', 4567).connect
end

class Xml
  def self.build(margin = 0)
    Builder::XmlMarkup.new #:indent => 2, :margin => margin
  end
end