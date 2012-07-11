class HistoriesController < ApplicationController
  before_filter :find_history

  def show_history
    @user_name=@history.user.name
    @question_title=@history.question.title
    @choice_letter=@history.choice.choice_letter

    render partial: "history"
  end

private
  
  def find_history
    @history=History.find params[:history_id]
  end
end
