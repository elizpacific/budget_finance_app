class RevenuesController < ApplicationController
  def index
    @revenues = Revenue.all.page(params[:page])

    @sum = []
    @revenues.each do |rev|
      if rev.user_id == current_user.id
        @sum << rev.sum
      end
    end
  end
  def show
    @revenue = Revenue.find(params[:id])
    @result = Revenue.sum(:sum)
  end

  def new
    @cards = Card.all
    @revenue = Revenue.new
    @revenues = Revenue.all
    @categories = Category.all
  end

  def create
    # render plain: params[:post].inspect
    @revenue = Revenue.new(revenue_params)

    if (@revenue.save)
      @new_balance = CardBalanceCreator.new.create_new_balance_by_rev(@revenue.card_id)
      redirect_to @revenue
    else
      render 'new'
    end
  end

  def edit
    @cards = Card.all
    @revenue = Revenue.find(params[:id])
  end

  def update
    @revenue = Revenue.find(params[:id])

    if @revenue.update(revenue_params)
      CardBalanceCreator.new.update_bal_after_update_rev(@revenue.id, @revenue.card_id)
      redirect_to @revenue
    else
      render 'revenues/edit'
    end
  end

  def destroy
    @revenue = Revenue.find(params[:id])
    CardBalanceCreator.new.update_after_delete_rev(@revenue.id, @revenue.card_id)

    @revenue.destroy

    redirect_to revenues_path
  end

  private def revenue_params
    params.require(:revenue).permit(:id, :sum, :data, :description, :card_id, :user_id)
  end
end
