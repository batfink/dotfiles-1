
######################################################################################
#
# Send a Cancelation report to Jess
#
# This report covers some basic cancelation information with important dates and user
# identifying information.
#
######################################################################################

begin

  #require './lib/mailer.rb'
  require './lib/database.rb'

  # Reports
  require './reports/export_entries.rb'


  ExportEntries.new.run(3)

rescue => e
  puts "failed"
  puts e.inspect
end
