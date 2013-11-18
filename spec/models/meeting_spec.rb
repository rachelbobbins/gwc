require 'spec_helper'

describe Meeting do
	describe "validations" do
		it { should validate_presence_of :starts_at }
		it { should validate_presence_of :ends_at }
		it { should validate_presence_of :description }
		it { should_not validate_presence_of :project_id }
	end
end