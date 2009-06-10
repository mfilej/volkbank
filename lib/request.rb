class Request

  attr_reader :action, :account, :params

  def initialize(action, account, params = {})
    @action = action
    @account = account
    @params = params
  end
  
  def action_params
    case action
    when :withdrawal, :deposit
      Xml.build(1).amount amount, :currency => currency
    when :create
      account.to_xml
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
        xml.account(:id => account.id) unless action == :create
        xml << action_params
      end
    end
  end
  
end