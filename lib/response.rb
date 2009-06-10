class Response
  
  attr_reader :account, :error_message
  
  def initialize(account, error_message = nil)
    @account = account
    @error_message = error_message
  end
  
  def status
    error_message ? 'fail' : 'ok'
  end
  
  def to_xml
    Xml.build.response :status => status do |xml|
      xml.error error_message if error_message
      xml << account.to_xml if account
    end
  end
  
  alias :body :to_xml
  
end