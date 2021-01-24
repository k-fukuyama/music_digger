require 'rails_helper'

describe 'grammies_api' do
  describe '#create' do
    subject { post '/api/v1/grammies', params: {grammy: params} }

    let(:artist_id) { song.artist.id }
    let(:discography) { song.discography }
    let(:song) { create(:song) }
    let(:genre) { create(:genre) }
    let(:params) do
      {
        artist_id: artist_id,
        song_id: song.id,
        grammy_type: '最優秀楽曲賞',
        genre_id: genre.id,
        year: Time.zone.now.year
      }
    end

    context 'when there are needs params' do
      it 'create grammy' do
        expect { subject }.to change(Grammy, :count).by(+1)
        expect(response.status).to eq(200)
      end
    end

    context 'when there are not needs params' do
      let(:artist_id) { nil }
      it 'dose not create grammy' do
        expect { subject }.not_to change(Grammy, :count)
        expect(response.status).to eq(500)
      end
    end
  end
end
