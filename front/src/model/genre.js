import axios from 'axios';

export default class Genre {
  post(genre) {
    return axios.post('http://localhost:3000/api/v1/genres', { genre: genre })
  }
}
