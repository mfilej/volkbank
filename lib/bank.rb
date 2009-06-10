class Bank
  
  ACCOUNTS = []
  
  class << self
    def next_account_id
      ACCOUNTS.size
    end
  
    def deposit(params)
      account = Account.find(params[:id])
      account.deposit(params)
    end
  
    def withdrawal(params)
      account = Account.find(params[:id])
      account.withdraw(params)
    end
  
    def create(params)
      account = Account.create(params)
    end
  
    def balance(params)
      account = Account.find(params[:id])
    end
  end
    
end