class TodoController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create 
    # begin
    puts "user id is #{todo_params[:user_id]}"
    todo_params.require([
      :user_id,
      :title,
      :description,
      :timer,
    ])
    user = User.find(todo_params[:user_id])
    
    # raise "User not found" unless user
    todo = Todo.new(
      title: todo_params[:title],
      description: todo_params[:description],
      status: :todo,
      timer: todo_params[:timer],
      remaining_time: todo_params[:timer],
    )
    user.todos << todo
    # user.save
    render json: {todo:todo, message: "Todo created succesfully"}, status: 200

  # rescue Exception => e

  # end

  end

  def list
    todo_params.require(:user_id)
    todos =  User.find(todo_params[:user_id]).todos
    render json: todos, status: 200
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
  end

  def destroy
    id = params[:id]
    res = Todo.delete(id)
    return render json: {res: res, message: "Todo with Id - #{id} deleted successfully"}, status: 200 unless res
    render json: {message: "delete failed successfully"}, status: 400
  end


  private
    def todo_params
      params.require(:todo).permit([
        :user_id,
        :title,
        :description,
        # :status,
        :timer,
        # :remaining_time
      ])
    end


end
