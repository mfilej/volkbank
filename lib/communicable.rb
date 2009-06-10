module Communicable

  def self.included(base)
    base.class_eval { attr_reader :socket }
  end
  
  def disconnect
    socket.close
    @reader = nil
    @writer = nil
    self
  end
  
  def write(data)
    @writer ||= PrintWriter.new(socket.get_output_stream, true)
    @writer.println(data)
  end
  
  def read
    @reader ||= BufferedReader.new(InputStreamReader.new(socket.get_input_stream))
    @reader.read_line
  end
  
end