class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.order(:title)
  end

  def show
    @symptom = Symptom.find(params[:id])
  end

  private

  def symptom_params
    params.require(:symptom).permit(:title, :summary, :home_care, :checkpoints, :visit_immediate, :visit_hours, :image)
  end
end
