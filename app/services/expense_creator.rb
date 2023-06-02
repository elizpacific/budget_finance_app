# frozen_string_literal: true
class ExpenseCreator

  def initialize(expenses)
    @expenses = expenses
  end

  def find_todays_expenses
    todays_expenses = []

    @expenses.each do |expense|
      if expense.data == Date.today
        todays_expenses << expense
      end
    end
    todays_expenses
  end

end
