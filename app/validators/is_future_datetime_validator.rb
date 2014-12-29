class IsFutureDatetimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Time.now < value
    	record.errors[attribute] << (options[:message] || "is not a valid date in the future") 
    end
  end
end