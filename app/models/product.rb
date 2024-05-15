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

    before_update :price_notification_changed, if: :price_changed?

    validates :description, presence: { message: 'A description is needed to create a new product' }
    
    validates :sku, presence: true
    validates :sku, uniqueness: { message: 'Code %{value} is already in use'}
    validates :sku, length: { in: 7..9 }

    validates_with ProductValidator
    
    scope :available, -> (min=1) { where('stock >= ?', min) }
    scope :order_price_asc, -> { order('price ASC') }

    scope :order_price_asc_availabilities, -> { available.order_price_asc }

    def good_offer?
        self.price < 10
    end

    def self.top_3_available
        self.available.order_price_asc.limit(3).select(:description, :stock, :price)
    end    

    private
    def notify_product_creation
        puts "#{self.description} was added to the products"
    end

    def push_notification
        puts "#{self.description} is now available at #{self.price}"
    end

    def price_notification_changed
        puts "price has been modified"
        puts "new price is #{self.price}, previous price was #{self.price_was}"
        price_variation = (((self.price-self.price_was)/self.price_was)*100).round(2)
        puts "Te price variation was of #{price_variation}%"
    end    
end
