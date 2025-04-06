class Villa < ApplicationRecord
  has_many :villa_calendars, dependent: :destroy
end
