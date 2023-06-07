class Request < ApplicationRecord
    belongs_to :client
    belongs_to :plan
    belongs_to :isp
    
    enum status: [ :pending, :approved, :rejected, :canceled]
    enum type_request: [:contracting, :change]
end
