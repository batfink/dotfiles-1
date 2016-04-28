require './lib/mailer.rb'
require './lib/database.rb'

# Reports
require './reports/cancels_last_n_months'

Mailer.deliver("callahanrts@gmail.com", "Subject", "Text", nil, CancelsLastNMonthsReport.new.run(3))

