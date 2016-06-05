require 'csv'
require './lib/database'
require 'yaml'

class ExportEntries

  def initialize
    @filepath = "./files/entries.csv"
  end

  def run(months)
    results = Database.new.run(query(months))
    create_report(results)
  end

private

  def create_report(results)
    CSV.open(@filepath, "wb") do |csv|
      csv << results.first.map{ |k, v| k }
      results.each{ |row|
        arr = [row["my_db_id"], row["working_tab_id"], row["email"], rows_from_hash(row["custom_data"])].flatten
        csv << arr
      }
    end

    return @filepath
  end

  def rows_from_hash(data)
    result = data.gsub("---", '').strip
    result = result.split("\n")
    result
  end

  def query(months)
    """
    SELECT my_db_id, working_tab_id, email, custom_data
    FROM my_db_entries
    WHERE my_db_id = 636787
    ORDER BY id DESC
    """
  end

end


