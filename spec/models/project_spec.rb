require 'spec_helper'

describe Project do
	describe ".validations" do
		it { should validate_presence_of :assignment_link }
		it { should validate_presence_of :name }
	end
end