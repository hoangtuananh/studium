class HistoriesController < ApplicationController
  before_filter :find_history

  def show_history
    render @history
  end

private
  
  def find_history
    @history=History.find params[:history_id]
  end
end
