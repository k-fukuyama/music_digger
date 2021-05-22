require 'rails_helper'

RSpec.describe V1::ArtistsApi do
  describe 'GET api/v1/artists' do
    let!(:artist) { create(:artist) }
    let(:expected) do
      [{
        id: artist.id,
        name: artist.name,
        birth_year: artist.birth_year,
        birth_month: artist.birth_month,
        birth_day: artist.birth_day,
        gender: artist.gender,
        country: artist.country
      }].to_json
    end

    it 'gets artists' do
      get 'http://localhost:3000/api/v1/artists'

      expect(response).to have_http_status(:success)
      expect(response.body).to eq expected
    end
  end

  describe 'POST api/v1/artists' do
    subject { post 'http://localhost:3000/api/v1/artists', params: params }
    let(:params) { {artist: { name: 'name', gender: '男性', country: 'japan', birth: '1993-06-25' }} }

    context 'when artists was created' do
      it 'returns { isCreated: true }' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq ({ isCreated: true }.to_json)
      end
    end

    context 'when artist was not created' do
      before { allow(V1::Services::ArtistService).to receive(:create!).and_raise(StandardError) }

      it 'returns 500 status' do
        subject
        expect(response).to have_http_status(500)
        expect(response.body).to eq ({'error'=>'Internal server error'}.to_json)
      end
    end
  end
end
