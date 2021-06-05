import axios from 'axios';

export default class Discography {
  property() {
    return {
      artist: '',
      title: '',
      sales_start_at: '',
      label: '',
      chart: '',
      explanation: '',
      discography_type: 0
    }
  }

  post(params) {
    return axios.post('http://localhost:3000/api/v1/genres', 
    { 
      discography: params['discography'], 
      song_infos: params['songs'], 
      grammy_flg: params['grammy_flg'], 
      set_same_artist: params['set_same_artist'] 
    })
  }
}
