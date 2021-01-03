import axios from 'axios';

export default class Genre {
  get(){
    return axios.get('/api/v1/genres.json')
  }
}
