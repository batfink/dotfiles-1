#!/usr/bin/ruby
# <bitbar.title>btc and eth prices</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Cody</bitbar.author>
# <bitbar.author.github>callahanrts</bitbar.author.github>
# <bitbar.desc>$$$</bitbar.desc>

require 'net/http'
require 'json'


eth = JSON.parse(`curl -s https://coinmarketcap-nexuist.rhcloud.com/api/eth`)
btc = JSON.parse(`curl -s https://coinmarketcap-nexuist.rhcloud.com/api/btc`)
puts "BTC: #{btc["price"]["usd"].round} ETH: #{eth["price"]["usd"].round(1)}"
