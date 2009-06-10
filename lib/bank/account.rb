class Bank::Account
  
  attr_reader :balance, :customer
  
  def initialize(customer)
    @customer = customer
    @balance = 0
  end
  
  [:id, :street, :phone, :ssn].each do |method|
    define_method(method) { customer[method].to_s }
  end
  
  def new?
    !id
  end
  
  def first_name
    customer[:name].split[0]
  end
  
  def last_name
    customer[:name].split[1]
  end
  
  def zip_code
    customer[:region].split[0]
  end
  
  def zip_name
    customer[:region].split[1]
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