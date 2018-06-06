class User < ApplicationRecord
  serialize :movies
  has_many :ratings
end
