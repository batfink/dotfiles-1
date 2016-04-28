require 'yaml'

class Config

  def self.credentials
    symbolize(YAML.load_file("./config/credentials.yaml"))
  end

  def self.database
    symbolize(YAML.load_file("./config/database.yaml"))
  end

private

  def self.symbolize(hash)
    hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

end
