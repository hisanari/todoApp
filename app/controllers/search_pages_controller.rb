class SearchPagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = TaskList.where(user_id: current_user.id).ransack(params[:q])
    @result = @q.result(distinct: true).includes(:todos)
  end

end
