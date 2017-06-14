class CarsController < ApplicationController
  URL = "http://localhost:3001/api/v2"


  def index
    @cars = Car.all
  end

  def show
    @car = Car.find_by(id: params[:id])
  end

  def new
    render :new
  end

  def create
    car = Car.create(vin: params[:vin], manufacture: params[:manufacture])
    # if car["errors"]
    #   flash[:warning] = car["errors"]
    #   redirect_to "/cars/new"
    # else
      redirect_to "/cars/#{car['id']}"
    # end
  end

  def destroy
    car = Car.find_by(id: params[:id])
    car.destroy
    redirect_to "/"
  end

  def edit
    @car = Car.find_by(id: params[:id])
  end

  def update
    car = Car.find_by(id: params[:id])
    car.update(vin: params[:vin], manufacture: params[:manufacture])
    redirect_to "/cars/#{car.id}"
  end

end
