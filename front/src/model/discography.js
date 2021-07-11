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
    return axios.post('http://localhost:3000/api/v1/discographies', params)
  }

  getDiscography(search_params = ''){
    return axios.get('http://localhost:3000/api/v1/discographies', {params:{ search_word: search_params}})
  }
}
