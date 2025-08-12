class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.order(:title)
  end

  def show; end

  def new
    @symptom = Symptom.new
  end

  def create
    @symptom = Symptom.new(symptom_params)
    if @symptom.save
      redirect_to @symptom, notice: '症状を登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @symptom.update(symptom_params)
      redirect_to @symptom, notice: '症状を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @symptom.destroy
    redirect_to symptoms_path, notice: '症状を削除しました。'
  end

  private

  def set_symptom
    @symptom = Symptom.find(params[:id])
  end

  def symptom_params
    params.require(:symptom).permit(:title, :summary, :home_care, :checkpoints, :visit_immediate, :visit_hours, :image)
  end
end
