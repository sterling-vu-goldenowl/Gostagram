require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validators' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
