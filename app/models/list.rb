class List < ActiveRecord::Base
    has_many :todos
    belongs_to :user
end
