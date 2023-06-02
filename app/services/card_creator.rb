# frozen_string_literal: true
class CardCreator

  def initialize(cards)
    @cards = cards
  end

  # find balance by card
  def find_balances
    cards_balances = []

    @cards.each do |card|
      cards_balances << CardBalance.where(card_name: card.name).last
    end
    cards_balances.to_a
  end

  # find last expense on a specific card
  def find_last_card_expense
    rev_balance = []

    @cards.each do |card|
      rev_balance << Expense.where(card_id: card.id).last
    end

    rev_balance.to_a
  end

  # find card by expense id
  # (this method for the output on home page about last expense)
  def find_card_by_exp_id
    @card_name = []
    n = 0

    find_last_card_expense.count do |temp|
      @card_name << Card.find(find_last_card_expense[n].card_id).name
      n+=1
    end
    @card_name

  end

  # find last expense on a specific card
  def find_last_card_revenues
    rev_balance = []

    @cards.each do |card|
      rev_balance << Revenue.where(card_id: card.id).last
    end

    rev_balance.to_a
  end

  # find card by revenue id
  # (this method for the output on home page about last revenue)
  def find_card_by_rev_id
    @card_name = []
    n = 0

    @cards.count do |cards|
      @card_name << Card.find(card.id).name
      n+=1
    end
    @card_name
  end

  def last_expense
    info = []
    expenses = find_last_card_expense

    expenses.each do |expense|
      if expense == nil
        info << 0
      else
        info << expense.sum
      end
    end

    info.to_a
  end

  def last_revenue
    info = []
    revenues = find_last_card_revenues

    revenues.each do |revenue|
      if revenue == nil
        info << 0
      else
      info << revenue.sum
      end
    end

    info.to_a
  end

  def find_card_id_by_name(name)
    Card.where(name: name).last.id
  end

end
