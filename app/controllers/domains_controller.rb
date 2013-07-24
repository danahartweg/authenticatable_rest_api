class DomainsController < ApplicationController

  before_filter :ensure_authenticated_user

  def index
    render json: Domain.all
  end

  def create
    domain = Domain.new(params[:domain])
    domain.save
    render json: domain
  end

  def show
    render json: Domain.find(params[:id])
  end

  def update
    domain = Domain.find(params[:id])
    domain.update_attributes(params[:domain])
    render json: domain
  end

  def destroy
    domain = Domains.find(params[:id])
    domain.destroy
    render json: domain
  end
end
