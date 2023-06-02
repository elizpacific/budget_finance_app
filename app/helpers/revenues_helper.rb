module RevenuesHelper

  def find_card_by_revenue(revenue_id)
    Card.find(revenue_id).name
  end

end
