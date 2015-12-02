class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [:voteable_type]
 

  def self.reset_charity_votes
    Vote.where(voteable_type: "Charity").delete_all
  end
end