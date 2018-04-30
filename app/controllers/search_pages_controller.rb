class SearchPagesController < ApplicationController
  before_action :authenticate_user!

  # /user/search_pages
  def index
    @task_result = current_user.task_lists.where(
      'title LIKE ?', "%#{params[:q]}%"
    )
    @todo_result = Todo.user_todos(
      current_user.task_lists.ids
    ).where('item LIKE ?', "%#{params[:q]}%").includes(:task_list)
  end
end
