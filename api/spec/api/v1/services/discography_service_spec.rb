require 'rails_helper'

RSpec.describe V1::Services::DiscographyService do
  describe '.create!' do
    subject { described_class.create!(discography, song_infos)}
    let(:discography) do
      {
        artist: artist.id,
        discography_type: 0, 
        title: 'title', 
        explanation: 'explanation', 
        sales_start_at: '2021-06-19',
        label: 'label'
      }
    end
    let(:song_infos) do
      [
        {
          track_number: 1,
          title: 'title',
          producer_id: producer.id,
          composer_id: '',
          lyricist_id: '',
          vocalist_id: '',
          bassist_id: '',
          guitarist_id: '',
          drummer_id: '',
          keyboardist_id: '',
          min: '3',
          sec: '30'
        }
      ]
    end
    let(:artist) { create(:artist) }
    let(:producer) { create(:artist) }

    it 'creates discography' do
      expect{ subject }.to change { Discography.count }.from(0).to(1)
    end

    it 'creates songs' do
      expect{ subject }.to change { Song.count }.from(0).to(1)
    end
  end
end
