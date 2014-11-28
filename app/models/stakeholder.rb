class Stakeholder < ActiveRecord::Base
	belongs_to :loginable, polymorphic: true
end
