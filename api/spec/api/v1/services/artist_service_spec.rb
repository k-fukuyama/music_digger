require 'rails_helper'

RSpec.describe V1::Services::ArtistService do
  describe '.fetch_all_artists' do
    subject { described_class.fetch_all_artists}
    let!(:target_artists) { [create(:artist)] }

    it { is_expected.to eq target_artists }
  end
end
