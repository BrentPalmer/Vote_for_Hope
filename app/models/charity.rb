class Charity < ActiveRecord::Base
  has_many :votes, as: :voteable
end