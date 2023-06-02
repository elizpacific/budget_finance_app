class HomeController < ApplicationController
  def welcome_page
    @cards = Card.all
    @revenues = Revenue.all
    @expenses = Expense.all

    @card_help = CardCreator.new(@cards)
    @revenue_help = RevenueCreator.new(@revenues)
    @expense_help = ExpenseCreator.new(@expenses)

    @last_balances = @card_help.find_balances
    @last_expense = @card_help.last_expense
    @last_revenue = @card_help.last_revenue

    @todays_expenses = @expense_help.find_todays_expenses
    @todays_revenues = @revenue_help.find_todays_revenues

    #@check = CardBalanceCreator.new.find_user_id_by_card_bal(id)
  end

  def about_us

  end
end
