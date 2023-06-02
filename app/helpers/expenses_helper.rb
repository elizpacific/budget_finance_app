module ExpensesHelper

  def find_card_by_expense(expense_id)
    Card.find(expense_id).name
  end

  def find_category_by_exp(category_id)
    Category.find(category_id).name
  end

  def find_card_by_exp(card_id)
    Card.find(card_id).name
  end

end
