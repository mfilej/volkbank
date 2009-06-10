class Response::Parser
  
  attr_reader :document
  
  def initialize(data)
    @document = Nokogiri::XML(data)
  end
  
  def status
    document.at('/response')['status']
  end
  
  def error_message
    return unless status == 'fail'
    document.at('error').content
  end
  
end