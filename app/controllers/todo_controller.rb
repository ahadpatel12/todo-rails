class TodoController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create 
    todo_params.require([
      :title,
      :description,
      :timer,
    ])
    user = User.find(@current_user[:id])
    todo = Todo.new(
      title: todo_params[:title],
      description: todo_params[:description],
      status: :todo,
      timer: todo_params[:timer],
      remaining_time: todo_params[:timer],
    )
    user.todos << todo
    render json: {todo:todo, message: "Todo created succesfully"}, status: 200
  end

  def list
    todos =  User.find(@current_user[:id]).todos
    render json: todos, status: 200
  end

  def find
    user = User.find(@current_user[:id])
    todo = user.todos.find(params[:id])
    return render json: {todo: todo, message: "Success"}, status: 200
 rescue ActiveRecord::RecordNotFound 
    render json: {error: "Todo not found with id #{todo_params[:id]}"}, status: 404
  end 

  def edit
    id = params[:id]
    todo_params.require([
      :user_id,
      :title,
      :description,
      :timer,
    ])
    user = User.find(todo_params[:user_id])
    todo = user.todos.find(id)
    todo.update(
      title: todo_params[:title],
      description: todo_params[:description],
      status: :todo,
      timer: todo_params[:timer],
      remaining_time: todo_params[:timer],
      )
    render json: {todo: todo, message: "Todo updated successfully"}
  rescue ActiveRecord::RecordNotFound 
    render json: {error: "Todo not found with id #{params[:id]}"}, status: 404

  end

  def destroy
    id = params[:id]
    res = Todo.delete(id)
    return render json: {res: res, message: "Todo with Id - #{id} deleted successfully"}, status: 200 unless res
    render json: {message: "delete failed successfully"}, status: 400
  end


  private
    def todo_params
      params.permit([
        :id,
        :user_id,
        :title,
        :description,
        # :status,
        :timer,
        # :remaining_time
      ])
    end

end
