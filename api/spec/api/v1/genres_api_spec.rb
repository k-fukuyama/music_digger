require 'rails_helper'

RSpec.describe V1::GenresApi do
  describe 'POST api/v1/genres' do
    subject { post 'http://localhost:3000/api/v1/genres', params: params }
    let(:params) { {genre: { name: 'name' }} }

    context 'when genres was created' do
      it 'returns { isCreated: true }' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq ({ isCreated: true }.to_json)
      end
    end

    context 'when genres was not created' do
      before { allow(V1::Services::GenreService).to receive(:create!).and_raise(StandardError) }

      it 'returns 500 status' do
        subject
        expect(response).to have_http_status(500)
        expect(response.body).to eq ({'error'=>'Internal server error'}.to_json)
      end
    end
  end
end
