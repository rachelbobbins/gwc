class Link < ActiveRecord::Base
	belongs_to :owner, polymorphic: true

	scope :by_priority, -> { order(:priority) }
end