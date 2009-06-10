class Response::Parser
  
  attr_reader :document
  
  def initialize(data)
    @document = Nokogiri::XML(data)
  end
  
  def status
    document.at('/response')['status']
  end
  
  def account_id
    document.at('account')['id']
  end
  
  def balance
    document.at('balance').content
  end
  
  def currency
    document.at('balance')['currency']
  end
  
  def success?
    status != 'fail'
  end
  
  def error_message
    return if success?
    document.at('error').content
  end
  
end