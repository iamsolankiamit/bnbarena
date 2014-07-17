class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topics = Topic.all
    @topic = Topic.find(params[:id])
    @articles = @topic.articles
  end
end
