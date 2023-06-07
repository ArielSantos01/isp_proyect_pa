class Isp < ApplicationRecord
    has_many :plans, dependent: :destroy
    has_many :requests


    before_create :set_token
    
    def set_token 
        self.token = SecureRandom.urlsafe_base64
    end
end
