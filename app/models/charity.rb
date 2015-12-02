class Charity < ActiveRecord::Base

  has_many :votes, as: :voteable

  validates_presence_of :name, :description, :mission_statement, :url

  def total_votes
    self.votes.where(vote: true).size
  end

  def self.winner_of_the_month
    charities = Charity.all
    charity_votes = {}

    charities.each do |c|
      charity_votes[c.name] = c.votes.size
    end

    winner = charity_votes.max_by{ |k,v| v}
    return winner
  end
end