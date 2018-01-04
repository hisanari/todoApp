class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @tasklists = current_user.task_lists.all
    @new_tasklist = current_user.task_lists.build
  end
end
