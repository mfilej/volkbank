class Request

  attr_reader :action, :params

  def initialize(action, params = {})
    @action = action
    @params = params
  end
  
  def account_id
    params[:account_id]
  end
  
  def action_params
    case action
    when :withdrawal, :deposit
      Xml.build(1).amount amount, :currency => currency
    when :create
      Bank::Account.new(params[:account]).to_xml
    else
      ""
    end
  end
  
  def amount
    params[:amount]
  end
  
  def currency
    params[:currency] || 'eur'
  end
  
  def to_xml
    returning Xml.build do |xml|
      xml.instruct!
      xml.request :action => action  do
        xml.account(:id => account_id) unless action == :create
        xml << action_params
      end
    end
  end
    
end