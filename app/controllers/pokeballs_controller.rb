class PokeballsController < ApplicationController
  def create
    @pokeball = Pokeball.new(pokeball_params)
    @pokemon = Pokemon.find(params[:pokemon_id])
    @pokeball.pokemon = @pokemon
    if @pokeball.save
      redirect_to trainer_path(@pokeball.trainer), notice: "You caught a Pokémon!"
    else
      flash[:alert] = "Your pokeball failed! Try again!"
      render "pokemons/show"
    end
  end

  private

  def pokeball_params
    params.require(:pokeball).permit(:location, :trainer_id, :caught_on)
  end
end
