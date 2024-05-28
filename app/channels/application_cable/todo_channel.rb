class TodoChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from "todo_#{params[:id]}"
  end
end