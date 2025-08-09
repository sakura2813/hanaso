class User < ApplicationRecord
  has_many :chat_threads, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
