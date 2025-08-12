class Symptom < ApplicationRecord
  has_many :chat_threads, dependent: :nullify
  has_one_attached :image
  validates :title, presence: true
end
