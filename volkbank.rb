require 'java'

include_class java.net.Socket
include_class java.net.ServerSocket
include_class java.io.PrintWriter
include_class java.io.BufferedReader
include_class java.io.InputStreamReader

require 'communicable'
require 'server'
require 'client'

def srv
  Server.new(4567).listen
end

def cli
  Client.new('localhost', 4567).connect
end