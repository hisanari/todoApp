class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    users_path
  end

  private

  def todo_limit_update
    tasklist_id = TaskList.where(user_id: current_user.id).ids
    todos = Todo.where(task_list_id: tasklist_id).order(:created_at)
    todos.each do |todo|
      if todo.todo_limit < Time.zone.today && todo.status != 'done'
        todo.status = 'expired'
        todo.save!
      end
    end
  end
end
