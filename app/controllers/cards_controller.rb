class CardsController < ApplicationController
  def index
    @cards = Card.all.page(params[:page])
    @cards_balances = CardCreator.new(@cards).find_balances
    @balances = CardBalance.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if (@card.save)

      redirect_to cards_path
    else
      if @card.errors.any?

        @card.errors.full_messages.each do |message|
          puts message
        end
      end
      render 'new'
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card
    else
      render 'cards/edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  private def card_params
    params.require(:card).permit(:id, :name, :balance_id, :user_id)
  end

end
