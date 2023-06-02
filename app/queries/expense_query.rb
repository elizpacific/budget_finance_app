# frozen_string_literal: true
class ExpenseQuery
  def initialize(expenses = Expense.all)
    @expenses = expenses
    end
end
