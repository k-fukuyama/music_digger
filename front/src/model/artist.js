import axios from 'axios';

export default class Artist {
  get(){
    return axios.get('http://localhost:3000/api/v1/artists')
  }
}
