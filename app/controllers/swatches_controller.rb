class SwatchesController < ApplicationController
  def index
    if params[:ids]
      Swatch.find(params['ids'])
    elsif params['collection']
      Collection.find(params['collection']).swatches
    else
      render json: Swatch.all
    end
  end

  def create
    swatch = Swatch.new(params[:swatch])
    swatch.save
    render json: swatch
  end

  def show
    render json: Swatch.find(params[:id])
  end

  def update
    swatch = Swatch.find(params[:id])
    swatch.update_attributes(params[:swatch])
    render json: swatch
  end

  def destroy
    swatch = Swatch.find(params[:id])
    swatch.destroy
    render json: swatch
  end
end
