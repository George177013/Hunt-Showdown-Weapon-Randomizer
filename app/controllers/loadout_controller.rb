class LoadoutController < ApplicationController
  def show
    @config = {
      slots: 4,
      budget: 10000,
      bloodline_rank: 100,
      tools_count: 4,
      consumables_count: 4,
      intelligent: true,
      dualies: true,
      force_medkit: true,
      force_melee: true
    }
    @loadout = Loadout.new
  end

  def randomize
    @config = config_params
  
    @loadout = Loadout.new
    @loadout.randomize(@config)
  
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("loadout", partial: "loadout/loadout", locals: { loadout: @loadout }) }
      format.html { render :show }
    end
  end
  

  private

  def config_params
    raw_params = params.require(:config).permit(
      :slots, :budget, :bloodline_rank, :tools_count, :consumables_count,
      :intelligent, :dualies, :force_medkit, :force_melee
    ).to_h.symbolize_keys

    {
      slots: raw_params[:slots].to_i,
      budget: raw_params[:budget].to_i,
      bloodline_rank: raw_params[:bloodline_rank].to_i,
      tools_count: raw_params[:tools_count].to_i,
      consumables_count: raw_params[:consumables_count].to_i,
      intelligent: to_boolean(raw_params[:intelligent]),
      dualies: to_boolean(raw_params[:dualies]),
      force_medkit: to_boolean(raw_params[:force_medkit]),
      force_melee: to_boolean(raw_params[:force_melee])
    }
  end

  def to_boolean(value)
    value == "true" || value == true
  end
end