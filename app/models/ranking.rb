class Ranking < ApplicationRecord

    validates :kilometers, presence: true
    validates :user_id, presence: true
    validates :startDate, presence: true
    validates :endDate, presence: true

    belongs_to :user

    def self.paginate(page=1, per_page=10)
        Ranking.order('sum_kilometers DESC').offset((page - 1) * per_page).limit(per_page)
    end
end
