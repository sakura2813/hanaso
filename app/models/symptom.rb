class Symptom < ApplicationRecord
  has_many :chat_threads, dependent: :nullify
  has_one_attached :image
  validates :title, presence: true

  # ▼ Ransack 検索を許可する属性を明示
  def self.ransackable_attributes(_auth_object = nil)
    %w[id title summary home_care checkpoints visit_immediate visit_hours created_at updated_at]
  end

  # ▼（必要なら）関連の検索許可。今回は検索しないので空でOK
  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
