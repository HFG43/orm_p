# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :string
#  sku         :string
#  stock       :integer          default(0)
#  price       :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord

    after_save :notify_product_creation
    after_save :push_notification, if: :good_offer?

    validates :description, presence: { message: 'A description is needed to create a new product' }
    
    validates :sku, presence: true
    validates :sku, uniqueness: { message: 'Code %{value} is already in use'}
    validates :sku, length: { in: 7..9 }

    validates_with ProductValidator
    
    def good_offer?
        self.price < 10
    end

    private
    def notify_product_creation
        puts "#{self.description} was added to the products"
    end

    def push_notification
        puts "#{self.description} is now available at #{self.price}"
    end    
end
