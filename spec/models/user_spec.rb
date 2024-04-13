require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o mail' do
      u = User.new(name: 'Julia Almeida', email: 'julia@yahoo.com')

      result = u.description()

      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end
end
