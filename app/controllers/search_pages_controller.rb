class SearchPagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = TaskList.includes(:todos).where(user_id: current_user.id).ransack(params[:q])
    @tasklists = @q.result(distinct: true)
  end
end
