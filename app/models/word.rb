class Word < ActiveRecord::Base

  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :word_lessons, dependent: :destroy
  has_many :lessons, through: :word_lessons
end
