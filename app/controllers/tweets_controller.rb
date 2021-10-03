class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(message: params[:tweet][:message],file: params[:tweet][:file].read,tdate: params[:tweet][:tdate]=Time.current.strftime("%H:%M"))
    if @tweet.save
      flash[:notice] = 'ツイートしました'
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      flash[:notice] = 'ツイートを削除しました'
    end
      redirect_to root_path
  end
  
  def show 
    @tweet = Tweet.find(params[:id])
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(message: params[:tweet][:message],file: params[:tweet][:file].read)
      flash[:notice] = "ツイートを更新しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def get_image
    tweet = Tweet.find(params[:id])
    send_data tweet.file, disposition: :inline, type: 'image/JPG'
  end
  
end
