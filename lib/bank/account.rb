class Bank::Account
  
  class NotEnoughFunds < StandardError; end
  
  attr_reader :customer
  
  class << self
    def find(name, id)
      Bank::ACCOUNTS[name] && Bank::ACCOUNTS[name][id]
    end

    def create(name, params)
      account = new(params)
      account[:account_id] = Bank::ACCOUNTS[name].size
      Bank::ACCOUNTS[name] << account
      account
    end
  end
  
  def initialize(customer)
    @customer = customer
  end
  
  def []=(key, value)
    customer[key] = value
  end
  
  def [](key)
    customer[key]
  end
  
  def balance
    @balance ||= 0
  end
  
  def withdraw(params)
    if params[:amount] > balance
      raise NotEnoughFunds.new()
    else
      @balance = balance - params[:amount]
    end
  end
  
  def deposit(params)
    @balance = balance + params[:amount]
  end
  
  [:account_id, :first_name, :last_name, :zip_code, :zip_name, :street, :phone, :ssn].each do |method|
    define_method(method) { customer[method].to_s }
  end
  
  def new?
    !account_id
  end
  
  def to_xml
    attrs = new? ? {} : { :id => account_id }
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