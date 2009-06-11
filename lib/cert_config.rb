module CertConfig
  
  protected
  
  def cert_config
    java.lang.System.setProperty("javax.net.ssl.keyStore", options[:key][:store])
    java.lang.System.setProperty("javax.net.ssl.keyStorePassword", options[:key][:pass])
    java.lang.System.setProperty("javax.net.ssl.trustStore", options[:trust][:store])
    java.lang.System.setProperty("javax.net.ssl.trustStorePassword", options[:trust][:pass])
  end
  
end