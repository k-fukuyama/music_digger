import axios from 'axios';

export default class Artist {
  get(){
    return axios.get('/api/v1/artists.json')
  }
}
