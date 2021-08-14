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

  describe '.fetch_by_id' do
    subject { described_class.fetch_by_id(artist_id)}

    context 'when artist exist' do
      let(:artist) { create :artist, birth_year: 1993, birth_month: 6, birth_day: 25 }
      let(:artist_id) { artist.id }

      it 'returns artist' do
        expect(subject).to eq ({:id=>artist.id, :name=>artist.name, :birth_day=>'1993-06-25', :gender=>artist.gender, :country=>nil})
      end
    end

    context 'when artist do not exist' do
      let(:artist_id) { 0 }
      
      it 'returns nil' do
        expect(subject).to eq nil
      end
    end
  end

  describe '.update' do
    subject { described_class.update(params)}

    context 'when artist exist' do
      let(:params) do
        {
          id: artist.id.to_s, 
          name: 'updated_name', 
          gender: '男性', 
          country: 'america', 
          birth_day: '1993-06-25'
        }
      end
      let(:artist) { create :artist }

      it 'updates artist' do
        expect{ subject }.to change { artist.reload.name }.from('name').to('updated_name')
                                                                       .and change{artist.reload.birth_year}.from(nil).to(1993)
                                                                       .and change{artist.reload.birth_month}.from(nil).to(6)
                                                                       .and change{artist.reload.birth_day}.from(nil).to(25)
                                                                       .and change{artist.reload.country}.from(nil).to('america')
                                                                       .and change{artist.reload.gender}.from('女性').to('男性')
      end
    end

    context 'when artist do not exist' do
      let(:params) { {id: 0} }

      it 'returns false' do
        expect(subject).to eq false
      end
    end
  end
end
