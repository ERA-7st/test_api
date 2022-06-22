class IdeasController < ApplicationController
  protect_from_forgery

  def index
  end

  def create
    category = Category.find_by(name: params[:category_name])
    if category.present?
      begin
        @idea = category.ideas.create!(body: params[:body])
      rescue
      end
    else
      ActiveRecord::Base.transaction do
        @category = Category.create!(name: params[:category_name])
        @idea = @category.ideas.create!(body: params[:body])
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
end
