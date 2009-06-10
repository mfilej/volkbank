class Bank::Account
  
  class NotEnoughFunds < StandardError; end
  
  attr_reader :balance, :customer
  
  class << self
    def find(id)
      Bank::ACCOUNTS[id]
    end

    def create(account)
      account.id = Bank.next_account_id
      accounts << account
    end
  end
  
  def initialize(customer)
    @customer = customer
    @balance = 0
  end
  
  def withdraw(amount)
    if amount >= balance
      raise NotEnoughFunds.new()
    else
      balance -= amount
    end
  end
  
  def deposit(amount)
    balance += amount
  end
  
  [:id, :first_name, :last_name, :zip_code, :zip_name, :street, :phone, :ssn].each do |method|
    define_method(method) { customer[method].to_s }
  end
  
  def new?
    !id
  end
  
  def to_xml
    attrs = new? ? {} : { :id => id }
    Xml.build(1).account(attrs) do |xml|
      xml.balance balance, :currency => 'eur'
      xml.owner do
        xml.name do
          xml.first first_name
          xml.last last_name
        end
        xml.address do
          xml.street street
          xml.region zip_name, :code => zip_code
        end
        xml.phone phone, :type => 'default'
        xml.ssn ssn
      end
    end
  end
  
end