class SessionsController < ApplicationController
   #POST /login/user
  def create
    user= User.find_by(username:params[:username])
    if user&.authenticate(params[:password])
      session[:user_id]=user.id
      render json: user
    else
      render json: {errors:["Wrong username or password"]}, status: :unprocessable_entity #422 
    end
  end
  #DELETE /logout
  def destroy
    if(session[:user_id])
      session.delete :user_id
      head :no_content
    else
      session.delete :editor_id
      head :no_content
    end
    
  end
end
