class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.order(:title)
  end

  def show
    @symptom = Symptom.find(params[:id])
  end
end
