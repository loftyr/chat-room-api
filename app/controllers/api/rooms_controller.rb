class Api::RoomsController < ApplicationController
  # GET /api/rooms
  def index
    rooms = Room.all.order(created_at: :desc)
    render json: rooms
  end

  # POST /api/rooms
  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/rooms/:id
  def update
    room = Room.find(params[:id])

    if room.update(room_params)
      render json: room
    else
      render json: room.errors, status: 422
    end
  end

  # DELETE /api/rooms/:id
  def destroy
    room = Room.find(params[:id])
    room.destroy
    render json: { message: "room deleted" }
  end

  # GET /api/rooms/:id
  def show
    room = Room.find(params[:id])
    render json: room
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
