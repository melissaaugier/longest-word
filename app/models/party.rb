class Party < ApplicationRecord
  belongs_to :game
  has_many :solutions

  validates :word, presence: true

  def is_french?
    dictionnaire = File.read(Rails.root.join('public', 'liste_francais.txt')).split("\n")
    dictionnaire.include? self.word
  end


end
