class Client < ApplicationRecord
    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, :email, :password, :address, presence: true
    validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/, message: "La contraseña debe contener al menos una letra mayuscula, una letra minuscula y un numero" }

    has_many :requests

    before_create :set_token
    
    def set_token 
        self.token = SecureRandom.urlsafe_base64
    end
end
