# frozen_string_literal: true
class CardBalanceCreator
  def initialize
    super
  end

  #while adding new expense
  def create_new_balance_by_exp(card_id)
    last_exp = Expense.where(card_id: card_id).last
    card_name = Card.find(card_id).name
    if CardBalance.where(card_name: card_name).last == nil
      card = 0
    else
      card = CardBalance.where(card_name: card_name).last.balance
    end
    sum = card - last_exp.sum

    CardBalance.new(
      balance: sum,
      date: Date.today,
      card_name: card_name
    ).save

    card = Card.find(card_id)
    card.balance_id = CardBalance.last.id
    card.save

  end

  #while adding new revenue
  def create_new_balance_by_rev(card_id)
    last_rev = Revenue.where(card_id: card_id).last
    card_name = Card.find(card_id).name
    if CardBalance.where(card_name: card_name).last == nil
      card = 0
    else
      card = CardBalance.where(card_name: card_name).last.balance
    end
    sum = card + last_rev.sum

    CardBalance.new(
      balance: sum,
      date: Date.today,
      card_name: card_name
    ).save

    card = Card.find(card_id)
    card.balance_id = CardBalance.last.id
    card.save
  end

  #update last card balance after updating any of expenses ;)
  def update_bal_after_update_exp(id, card_id)
    last_exp = Expense.find(id)
    last_rev = Revenue.where(card_id: card_id).last.sum
    card_name = Card.find(card_id).name
    card_balance = CardBalance.where(card_name: card_name).second_to_last.balance
    sum = card_balance - last_exp.sum + last_rev

    balance = CardBalance.where(card_name: card_name).last
    balance.balance = sum
    balance.save
  end

  #update last card balance after updating any of revenues ;)
  def update_bal_after_update_rev(id, card_id)
    if Expense.where(card_id: card_id).last != nil
      last_exp = Expense.where(card_id: card_id).last.sum
    else
      last_exp = 0
    end

    last_rev = Revenue.where(card_id: card_id).last.sum
    card_name = Card.find(card_id).name

    if CardBalance.where(card_name: card_name).second_to_last == nil
      card_balance = CardBalance.where(card_name: card_name).last.balance
    else
      card_balance = CardBalance.where(card_name: card_name).second_to_last.balance
    end
    if last_exp == 0
      sum = last_rev
    else
      sum = card_balance + last_rev - last_exp
    end

    balance = CardBalance.where(card_name: card_name).last
    balance.balance = sum
    balance.save
  end

  def update_after_delete_exp(id, card_id)
    exp = Expense.find(id).sum
    card_name = Card.find(card_id).name
    card_balance = CardBalance.where(card_name: card_name).last.balance
    sum = card_balance + exp

    balance = CardBalance.where(card_name: card_name).last
    balance.balance = sum
    balance.save
  end

  def update_after_delete_rev(id, card_id)
    exp = Revenue.find(id).sum
    card_name = Card.find(card_id).name
    card_balance = CardBalance.where(card_name: card_name).last.balance
    sum = card_balance - exp

    balance = CardBalance.where(card_name: card_name).last
    balance.balance = sum
    balance.save
  end

  def find_user_id_by_card_bal(id)
    if Card.where(balance_id: id).last == nil
      Card.last.user_id
      else
      Card.where(balance_id: id).last.user_id
      end
  end

end
