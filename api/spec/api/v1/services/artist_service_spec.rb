require 'rails_helper'

RSpec.describe V1::Services::ArtistService do
  describe '.fetch_all_artists' do
    subject { described_class.fetch_all_artists}
    let!(:target_artists) { [create(:artist)] }

    it { is_expected.to eq target_artists }
  end

  describe '.create!' do
    subject { described_class.create!(params[:artist])}
    let!(:params) { {artist: { name: 'name', gender: '男性', country: 'japan', birth: '1993-06-25' }} }

    it 'creates artist' do
      expect{ subject }.to change { Artist.count }.from(0).to(1)
    end
  end
end
