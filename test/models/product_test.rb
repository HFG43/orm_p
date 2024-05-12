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
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
