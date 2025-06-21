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

  def destroy
    @pokeball = Pokeball.find(params[:id])
    @pokeball.destroy
    redirect_to trainer_path(@pokeball.trainer), notice: "#{@pokeball.pokemon.name} has been released!"
  end

  private

  def pokeball_params
    params.require(:pokeball).permit(:location, :trainer_id, :caught_on)
  end
end
