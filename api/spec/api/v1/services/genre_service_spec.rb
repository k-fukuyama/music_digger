require 'rails_helper'

RSpec.describe V1::Services::GenreService do
  describe '.create!' do
    subject { described_class.create!('genre')}

    it 'creates genre' do
      expect{ subject }.to change { Genre.count }.from(0).to(1)
    end
  end
end
