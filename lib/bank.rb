class Bank
  
  ACCOUNTS = Hash.new { |h, k| h[k] = []  }
  
  class << self
    def deposit(params)
      if account = Account.find(params[:name], params[:id])
        account.deposit(params)
        Response.new(account)
      else not_found
      end
    end
  
    def withdrawal(params)
      if account = Account.find(params[:name], params[:id])
        account.withdraw(params)
        Response.new(account)
      else not_found
      end
    rescue Account::NotEnoughFunds
      Response.new(account, "Not enough funds to perform withdrawal")
    end
  
    def create(params)
      account = Account.create(params[:name], params)
      Response.new(account)
    end
  
    def balance(params)
      if account = Account.find(params[:name], params[:id])
        Response.new(account)
      else
        not_found
      end
    end
  
    protected
  
    def not_found
      Response.new(nil, "Account not found")
    end
    
  end
    
end