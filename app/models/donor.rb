class Donor < ActiveRecord::Base
	has_many :stakeholders, as: :loginable
end
