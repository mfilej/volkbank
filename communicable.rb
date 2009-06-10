module Communicable

  def self.included(base)
    base.class_eval { attr_reader :socket }
  end

  def writer
    @writer ||= PrintWriter.new(socket.get_output_stream, true)
  end
  
  def reader
    @reader ||= BufferedReader.new(InputStreamReader.new(socket.get_input_stream))
  end
  
end