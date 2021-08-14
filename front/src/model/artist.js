import axios from 'axios';

export default class Artist {
  get(){
    return axios.get('http://localhost:3000/api/v1/artists')
  }

  getById(artist_id){
    return axios.get(`http://localhost:3000/api/v1/artists/${artist_id}`)
  }

  update(artist) {
    return axios.patch(`http://localhost:3000/api/v1/artists/${artist.id}`, artist)
  }
}
