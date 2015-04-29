# == Schema Information
#
# Table name: users
#
#  idUser             :integer          not null, primary key
#  name               :string(100)      not null
#  lastname           :string(100)
#  email              :string(100)      not null
#  encrypted_password :string(255)      not null
#  salt               :string(200)
#  updatedAt          :datetime         not null
#  createdAt          :datetime         not null
#  deletedAt          :datetime
#  lastConnection     :datetime         not null
#  rfc                :string(255)
#  curp               :string(255)
#  avatar             :string(255)
#  admin              :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
