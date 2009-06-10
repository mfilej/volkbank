module Communicable

  def self.included(base)
    base.class_eval { attr_reader :socket }
  end
  
  def disconnect
    socket.close
    self
  end
  
  def write(data)
    PrintWriter.new(socket.get_output_stream, true).tap do |writer|
      writer.print(data)
    end.close
  end
  
  def read
    reader = BufferedReader.new(InputStreamReader.new(socket.get_input_stream))
    StringIO.new.tap do |out|
      until (data = reader.read) < 0
        out.putc data
      end
    end.string
  end
  
end