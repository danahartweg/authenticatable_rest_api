class ManufacturersController < ApplicationController
  def index
    render json: Manufacturer.all
  end

  def create
    manufacturer = Manufacturer.new(params[:manufacturer])
    manufacturer.save
    render json: manufacturer
  end

  def show
    render json: Manufacturer.find(params[:id])
  end

  def update
    manufacturer = Manufacturer.find(params[:id])
    manufacturer.update_attributes(params[:manufacturer])
    render json: manufacturer
  end

  def destroy
    manufacturer = Manufacturer.find(params[:id])
    manufacturer.destroy
    render json: manufacturer
  end
end
