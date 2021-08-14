require 'rails_helper'

RSpec.describe V1::ArtistsApi do
  describe 'GET api/v1/artists' do
    let!(:artist) { create(:artist) }
    let(:expected) do
      [{
        id: artist.id,
        name: artist.name,
        birth_day: nil,
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

  describe 'GET api/v1/artists/:id' do
    subject { get "http://localhost:3000/api/v1/artists/#{artist_id}" }

    context 'when artist exist' do
      let(:artist) { create(:artist) }
      let(:artist_id) { artist.id }
      let(:expected) do
        {
          id: artist.id,
          name: artist.name,
          birth_day: nil,
          gender: artist.gender,
          country: artist.country
        }.to_json
      end

      it 'gets artist' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq expected
      end
    end

    context 'when artist do not exist' do
      let(:artist_id) { 0 }
      it 'returns 404 status' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'patch api/v1/artists/:id' do
    subject { patch "http://localhost:3000/api/v1/artists/#{artist_id}", params: params }

    let(:params) { {id: artist_id, name: 'new_name', birth_day: '1993-06-25', gender: '男性', country: 'japan'} }

    context 'when update succeeded' do
      let(:artist) { create(:artist) }
      let(:artist_id) { artist.id }

      it 'returns success status' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq ({is_updated: true}).to_json
      end
    end

    context 'when artist do not exist' do
      let(:artist_id) { 0 }

      it 'returns 404 status' do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context 'when update failed' do
      let(:artist_id) { 0 }

      before { allow(Artist).to receive(:find_by).and_raise(StandardError) }

      it 'returns 500 status' do
        subject
        expect(response).to have_http_status(500)
      end
    end
  end
end
