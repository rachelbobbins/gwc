require 'spec_helper'

describe User do
	describe "validations" do
		it { should ensure_inclusion_of(:role).in_array(['teacher', 'student']) }
	end
end