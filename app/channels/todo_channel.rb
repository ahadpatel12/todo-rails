class TodoChannel < ApplicationCable::Channel
  # skip_before_action :authenticate_user
  
  def subscribed
    stream_from "todo_channel"
    pp "connected to channel todo_channel"
  end

  # def speak
  #   ActionCable.server.broadcast "todo_channel", message: "Your message has been sended", status: 200
  # end

  # def send()
  #   ActionCable.server.broadcast("todo_channel", data)
  # end

  def receive data
    ActionCable.server.broadcast("todo_channel", data)
  end
  # def receive(data)
  #   ActionCable.server.broadcast("todo", { body: "This Room is Best Room." })
  #   # ActionCable.server.broadcast "todo_#{params[:room]}", message: data
  # end


end