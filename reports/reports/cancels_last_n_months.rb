require 'csv'
require './lib/database'

class CancelsLastNMonthsReport

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
    SELECT IF(subscriptions.canceled_user_id IS NULL, subscriptions.user_id, subscriptions.canceled_user_id) AS 'user_id',
           subscriptions.created_at AS 'subscribed_at',
           subscriptions.canceled_at AS 'canceled',
           users.created_at AS 'signed_up',
           users.email AS 'email',
           subscriptions.cardholder_email,
           subscriptions.state,
           users.name,
           plans.handle,
           plans.name,
           plans.interval,
           plans.interval_unit
    FROM subscriptions
    LEFT JOIN plans ON plans.id = subscriptions.plan_id
    LEFT JOIN users ON users.id = IF(subscriptions.canceled_user_id IS NULL, subscriptions.user_id, subscriptions.canceled_user_id)
    WHERE subscriptions.state = 'canceled'
      AND subscriptions.canceled_at >= CURDATE() - INTERVAL #{months} MONTH
    """
  end

end

