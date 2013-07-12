class CollectionsController < ApplicationController

  prepend_before_filter :get_api_key
  before_filter :authenticate_user!

  def index
    render json: Collection.all
  end

  def create
    collection = Collection.new(params[:collection])
    collection.save
    render json: collection
  end

  def show
    render json: Collection.find(params[:id])
  end

  def update
    collection = Collection.find(params[:id])
    collection.update_attributes(params[:collection])
    render json: collection
  end

  def destroy
    collection = Collection.find(params[:id])
    collection.destroy
    render json: collection
  end
end
