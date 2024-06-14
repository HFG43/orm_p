# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint           not null, primary key
#  total      :integer          default(0)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_products
  has_many :products, through: :shopping_cart_products 

  
  #Este método se usará tras agregar o sacar cualquier producto del carrito
  def update_total!
    self.update(total: self.total_amount)
  end

  def total_amount

    total = 0

    self.products.each do |product|
      total += product.price
    end
    
    total
  end  
end
