require 'csv'
require './lib/database'

class SignUpsLastNMonthsReport

  def initialize
    @filepath = "./files/cancels_last_n_months.csv"
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
        arr = row.map{ |k, v| v }
        csv << arr
      }
    end

    return @filepath
  end

  def query(months)
    """
    SELECT users.id AS 'user_id',
           users.email,
           subscriptions.cardholder_email,
           users.created_at AS 'created_account',
           users.last_login_at,
           users.email_verified,
           subscriptions.created_at AS 'signed_up',
           plans.name,
           plans.handle,
           plans.interval,
           plans.interval_unit
    FROM users
    LEFT JOIN subscriptions ON subscriptions.user_id = users.id
    LEFT JOIN plans ON plans.id = subscriptions.plan_id
    WHERE users.created_at >= CURDATE() - INTERVAL 2 MONTH
    ORDER BY users.id desc
    """
  end

end

