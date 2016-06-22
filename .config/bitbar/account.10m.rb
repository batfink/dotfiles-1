#!/usr/bin/ruby
# <bitbar.title>$ on Coinbase</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Cody</bitbar.author>
# <bitbar.author.github>callahanrts</bitbar.author.github>
# <bitbar.desc>$$$</bitbar.desc>

require 'openssl'
require 'json'
require 'yaml'
require 'date'

class CoinbaseWallet
  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def signature(request_path='', body='', timestamp=nil, method='GET')
    body = body.to_json if body.is_a?(Hash)
    timestamp = Time.now.utc.to_i if !timestamp

    message = "#{timestamp}#{method}#{request_path}#{body}"

    # create a sha256 hmac with the secret
    hash = OpenSSL::HMAC.hexdigest('sha256', @secret, message)
  end

  def balance
    ts = Time.now.to_i #JSON.parse(`curl https://api.coinbase.com/v2/time`)["data"]["epoch"]
    sig = signature('/v2/accounts/primary', nil, ts, 'GET')
    JSON.parse(`curl -s https://api.coinbase.com/v2/accounts/primary -H "CB-ACCESS-KEY: #{@key}" -H "CB-ACCESS-SIGN: #{sig}" -H "CB-ACCESS-TIMESTAMP: #{ts}"`)
  end

  def difference
    b = balance["data"]["native_balance"]["amount"].to_f
    start = Date.parse("2016/02/25")
    end_date = Date.today
    weeks = ((end_date - start) / 7).abs.to_i + 1
    spent = weeks * 50
    net = (b - spent).round(2)
    color = net >= 0 ? 'green' : 'red'
    "#{net.abs} | color=#{color}"
  end

end


creds = YAML.load_file('/Users/codycallahan/dotfiles/secrets/coinbase.yml')
wallet = CoinbaseWallet.new(creds["coinbase"]["api_key"], creds["coinbase"]["api_secret"])
# puts "  $#{wallet.balance["data"]["native_balance"]["amount"]}  "
puts wallet.difference

