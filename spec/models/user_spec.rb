require 'spec_helper'

describe User do
	describe "validations" do
		it { should ensure_inclusion_of(:role).in_array(['teacher', 'student']) }
		it { should validate_presence_of(:first_name) }
		it { should validate_presence_of(:last_name) }
	end
end