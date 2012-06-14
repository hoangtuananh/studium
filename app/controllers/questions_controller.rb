class QuestionsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def category_selection
    @categories=CategoryType.order :category_name
    @category_names=@categories.collect do |category|
      category.category_name
    end
  end
end
