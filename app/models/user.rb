class User < ApplicationRecord
  has_many :notes, dependent: :delete_all
end
