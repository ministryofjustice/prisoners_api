require 'rails_helper'

RSpec.describe RoleConstraint do
  describe '#matches?' do
    let(:request) { double }
    let(:user) { create(:user, :admin) }

    subject { RoleConstraint.new('admin') }

    before :each do
      env = double
      allow(request).to receive(:env).and_return(env)
      allow(env).to receive(:[]).with('warden').and_return(env)
      allow(env).to receive(:user).and_return(user)
    end


    context 'when role matches' do
      it 'returns true' do
        expect(subject.matches?(request)).to eq(true)
      end
    end

    context 'when role does not match' do
      before { user.update_attribute(:role, 'staff') }

      it 'returns true' do
        expect(subject.matches?(request)).to eq(false)
      end
    end
  end
end
