class PerksController < ApplicationController
  def charts
    @expenses = Expense.all
    @revenues = Revenue.all

    @chart_rev = []
    @chart_exp = []

    sum = []
    data = []

    @expenses.each do |expense|
      if expense.user_id == current_user.id
        sum << expense.sum
      end
    end

    @expenses.each do |expense|
      if expense.user_id == current_user.id
        data << expense.data
      end
    end

    @chart_exp = Expense.where(sum: sum, data: data)

    ####################################################

    @revenues.each do |revenue|
      if revenue.user_id == current_user.id
        sum << revenue.sum
      end
    end

    @revenues.each do |revenue|
      if revenue.user_id == current_user.id
        data << revenue.data
      end
    end

    @chart_rev = Revenue.where(sum: sum, data: data)

  end
end
