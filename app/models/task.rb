# frozen_string_literal: true

class Task < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title

  scope :not_archived, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :overdue, -> { where('deadline < ?', Date.today) }
end
