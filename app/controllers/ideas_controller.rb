class IdeasController < ApplicationController
  protect_from_forgery
  before_action :set_category, only: [:index, :create]

  def index
    if params[:category_name].nil?
      @ideas = Idea.all
    elsif @category
      @ideas = @category.ideas
    end
    @ideas ? (render json: @ideas)  :  (render json: 404, status: 404)
  end

  def create
    if @category.present?
      begin
        @idea = @category.ideas.create!(body: params[:body])
      rescue
      end
    else
      ActiveRecord::Base.transaction do
        @new_category = Category.create!(name: params[:category_name])
        @idea = @new_category.ideas.create!(body: params[:body])
      rescue
        raise ActiveRecord::Rollback
      end
    end
    if @idea.present?
      render json: 201, status: 201
    else
      render json: 422, status: 422
    end
  end

  private
  
  def set_category
    @category = Category.find_by(name: params[:category_name])
  end

end
