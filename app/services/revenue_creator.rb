# frozen_string_literal: true
class RevenueCreator
  def initialize(revenues)
    @revenues = revenues
  end

  def find_todays_revenues
    todays_revenues = []

    @revenues.each do |revenue|
      if revenue.data == Date.today
      todays_revenues << revenue
      end
    end
    todays_revenues
  end
end
