require 'rails_helper'

RSpec.describe V1::GenresApi do
  describe 'POST api/v1/genres' do
    subject { post 'http://localhost:3000/api/v1/discographies', params: params }
    let(:params) do
      {
        discography: {
          artist: artist.id,
          title: 'title',
          sales_start_at: '2021-06-19',
          label: 'label',
          chart: '1',
          explanation: 'explanation',
          discography_type: 0
        },
        song_infos: [
          track_number: 1,
          title: 'title',
          producer_id: '',
          composer_id: '',
          lyricist_id: '',
          vocalist_id: '',
          bassist_id: '',
          guitarist_id: '',
          drummer_id: '',
          keyboardist_id: '',
          min: '3',
          sec: '30'
        ]
      }
    end
    let(:artist) { create(:artist) }

    context 'when discography was created' do
      it 'returns { isCreated: true }' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to eq ({ isCreated: true }.to_json)
      end
    end

    context 'when discography was not created' do
      before { allow(V1::Services::DiscographyService).to receive(:create!).and_raise(StandardError) }

      it 'returns 500 status' do
        subject
        expect(response).to have_http_status(500)
        expect(response.body).to eq ({'error'=>'Internal server error'}.to_json)
      end
    end
  end
end
