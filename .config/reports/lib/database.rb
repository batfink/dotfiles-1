require './lib/config.rb'
require 'mysql2'

class Database

  def initialize
    @client = Mysql2::Client.new(Config.database)
  end

  def run(query)
    @client.query(query)
  end

end
