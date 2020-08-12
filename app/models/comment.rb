class Comment < ApplicationRecord
    belongs_to :recipe
    belongs_to :user

    validates :content, presence: true, length: {minimum: 2}

    def self.group_by_user
        all.group_by(&:user)
    end
    
end
