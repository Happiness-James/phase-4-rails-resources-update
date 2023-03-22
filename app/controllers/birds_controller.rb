class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    if bird
      render json: bird
    else
      render_not_found
    end
  end

    # PATCH /birds/:id
    def update
      bird = find_bird
      if bird
        bird.update(bird_params)
        render json: bird
      else
        render_not_found
      end
    end

    def increment_likes
      bird = find_bird
      if bird
        bird.update(likes: bird.likes + 1)
        render json: bird
      else
        render_not_found
      end    
    end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def find_bird
    Bird.find_by(id: params[:id])
  end

  def render_not_found
    render json: {error: "Bird not found"}, status: :not_found
  end

end
