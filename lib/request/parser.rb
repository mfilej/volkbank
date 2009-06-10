class Request::Parser

  attr_reader :document

  def initialize(data)
    @document = Nokogiri::XML(data)
  end

  def action
    document.at('/request')['action']
  end

  def account_id
    document.at('/request/account')['id']
  end

  def account
    Bank::Account.find(account_id)
  end

  def params
    case action
    when 'balance'
      {}
    when 'withdrawal', 'deposit'
      amount = document.at '/request/amount'
      { :amount => amount.content.to_f,
        :currency => amount['currency']  }
    when 'create'
      owner = document.at '/request/account/owner'
      {
        :first_name => owner.at('./name/first').content,
        :last_name => owner.at('./name/last').content,
        :street => owner.at('./address/street').content,
        :zip_code => owner.at('./address/region')['code'],
        :zip_name => owner.at('./address/region').content,
        :phone => owner.at('./phone').content,
        :ssn => owner.at('./ssn').content
      }
    end
  end

end