# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  email      :string           not null
#  document   :integer
#  province   :string
#  postalcode :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    has_many :shopping_carts
    has_one :shopping_cart, -> { where(active:true).order('id DESC') }
end
