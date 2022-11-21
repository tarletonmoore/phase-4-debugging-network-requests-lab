class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    toy = find_toy
    toy.update!(toy_params)
    render json: toy
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private

  def find_toy
    Toy.find(params[:id])
  end
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

end
