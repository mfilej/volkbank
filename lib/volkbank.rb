require 'java'
require 'stringio'
require 'rubygems'
require 'builder'

include_class java.net.Socket
include_class java.net.ServerSocket
include_class java.io.PrintWriter
include_class java.io.BufferedReader
include_class java.io.InputStreamReader

%w{ core_ext
    communicable listener server client
    request
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
    Builder::XmlMarkup.new :indent => 2, :margin => margin
  end
end