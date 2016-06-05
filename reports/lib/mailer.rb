require 'gmail'
require './lib/config.rb'

class Mailer

  def self.deliver(address, sub, msg, html=nil, filepath=nil)
    credentials = Config.credentials
    gmail = Gmail.new(credentials[:username], credentials[:password])

    gmail.deliver! do
      to address
      subject sub
      cc credentials[:username]

      text_part do
        body msg
      end

      unless html.nil?
        html_part do
          content_type 'text/html; charset=UTF-8'
          body html
        end
      end

      add_file filepath unless filepath.nil?
    end

    gmail.logout
  end

end

