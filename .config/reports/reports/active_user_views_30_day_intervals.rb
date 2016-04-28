require 'csv'
require './lib/database'

class ActiveUserViews30DayIntervals

  def initialize
    @filepath = "./files/active_user_views_30_day_intervals.csv"
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
    SELECT subscriptions.user_id,
           plans.name,
           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 30 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 0 DAY) AS '0-30 Days',

           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 60 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 30 DAY) AS '30-60 Days',

           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 90 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 60 DAY) AS '60-90 Days',


           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 120 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 90 DAY) AS '90-120 Days',

           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 150 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 120 DAY) AS '120-150 Days',

           (SELECT COUNT(anal_views.id)
            FROM anal_views
            WHERE anal_views.user_id = subscriptions.user_id
              AND anal_views.viewed_at > CURDATE() - INTERVAL 180 DAY
              AND anal_views.viewed_at < CURDATE() - INTERVAL 150 DAY) AS '150-180 Days'
    FROM subscriptions
    JOIN plans ON plans.id = subscriptions.plan_id
    WHERE state = 'active'
    ORDER BY subscriptions.user_id
    """
  end

end


