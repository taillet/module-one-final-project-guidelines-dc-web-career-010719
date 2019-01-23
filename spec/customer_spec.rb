require_relative 'spec_helper'

  describe "Customer" do

  let (:checker) {Customer.new}
    it 'check get all customer' do
      expect(checker.get_all_customer_reviews).to eq()
    end

end
