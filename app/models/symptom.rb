class Symptom < ApplicationRecord
  has_many :chat_threads, dependent: :nullify
  validates :title, presence: true
end
