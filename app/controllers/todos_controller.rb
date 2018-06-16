class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :exists_tasklist

  # GET user/task_list/task_list_id/todos
  def index
    @todos = @tasklist.todos.order(created_at: :desc).page(params[:page]).per(3)
    @new_todo = @tasklist.todos.build
  end

  # POST /user/task_lists/:task_list_id/todos
  def create
    @new_todo = @tasklist.todos.build(todo_params)

    if @new_todo.save
      redirect_to task_list_todos_path, notice: '新しいTodoが作成されました。'
    else
      @todos = @tasklist.todos.order(created_at: :desc).page(params[:page]).per(3)
      render 'todos/index'
    end
  end

  # GET /user/task_lists/:task_list_id/todos/:id/edit
  def edit
    @user_tasklists = current_user.task_lists
    @todo = @tasklist.todos.find_by(id: params[:id])
  end

  # /user/task_lists/:task_list_id/todos/:id
  def update
    @todo = @tasklist.todos.find_by(id: params[:id])
    respond_to do |format|
      # 変更内容がある場合ステータスを未完了にする
      @todo.status = 0 unless @todo.params_equal?(todo_params)
      if @todo.update(todo_params)
        format.html { redirect_to task_list_todos_path, notice: '変更されました。' }
      else
        @user_tasklists = current_user.task_lists
        format.js {}
      end
    end
  end

  # DELETE /user/task_lists/:task_list_id/todos/:id
  def destroy
    Todo.find_by(id: params[:id]).destroy
    redirect_to task_list_todos_path, alert: '削除しました。'
  end

  private

    def todo_params
      params.require(:todo).permit(:item, :todo_limit, :task_list_id)
    end

    def exists_tasklist
      @tasklist = current_user.task_lists.find_by(id: params[:task_list_id])
      redirect_to users_path, alert: '存在しないか、権限がありません。' if @tasklist.nil?
    end
end
