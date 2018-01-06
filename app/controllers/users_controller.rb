class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @tasklists = current_user.task_lists.created_latest_order
    @new_tasklist = current_user.task_lists.build
  end
end
