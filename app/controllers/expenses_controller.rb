class ExpensesController < ApplicationController
  def index
    @q = Expense.ransack(params[:q])
    @expenses = @q.result(distinct: true).page(params[:page])
    #@expenses = Expense.all.page(params[:page])

    @sum = []
    @expenses.each do |exp|
      if exp.user_id == current_user.id
        @sum << exp.sum
      end
    end
  end

  def new
    @cards = Card.all
    @expense = Expense.new
    @expenses = Expense.all
    @categories = Category.all
  end

  def create
    #card_id = CardCreator.new(Card).find_card_id_by_name(expense_params[:card_name])

    @expense = Expense.new(expense_params)
    if (@expense.save)

      #expense = Expense.find(@expense.id)
      #expense.card_id = card_id
      #expense.save
      @new_balance = CardBalanceCreator.new.create_new_balance_by_exp(@expense.card_id)

      redirect_to @expense
    else
      if @expense.errors.any?
        binding.pry
        @expense.errors.full_messages.each do |message|
          puts message
        end
      end
      render 'new'
    end
  end
  def show
    @expense = Expense.find(params[:id])
    @result = Expense.sum(:sum)
  end

  def edit
    @cards = Card.all
    @categories = Category.all
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      CardBalanceCreator.new.update_bal_after_update_exp(@expense.id, @expense.card_id)
      redirect_to @expense
    else
      render 'expenses/edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    CardBalanceCreator.new.update_after_delete_exp(@expense.id, @expense.card_id)

    @expense.destroy

    redirect_to expenses_path
  end

  def search
    @expenses = Expense.all
  end

  private def expense_params
    params.require(:expense).permit(:id, :sum, :data, :description, :category_id, :card_id,:card_name, :user_id)
  end
end
