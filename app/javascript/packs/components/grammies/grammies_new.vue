<template>
  <v-app>
    <v-card>
      <v-tabs
          background-color="deep-purple accent-4"
          center-active
          dark
      >
      <v-tab v-on:click="buttonChange('single')">Single</v-tab>
      <v-tab v-on:click="buttonChange('album')">Album</v-tab>
      </v-tabs>
    </v-card>
    <div v-show="grammyType=='single'">
      <SingleGrammies></SingleGrammies>
    </div>
    <div v-show="grammyType=='album'">
      <p>album</p>
    </div>
  </v-app>
</template>

<script>
  import axios from 'axios';
  import Artist from '../../model/artist.js'
  import Genre from '../../model/genre.js'
  import Song from '../../model/song.js'
  import Discography from '../../model/discography.js'
  import SingleGrammies from './single_grammies.vue'

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  const artist = new Artist()
  const genre = new Genre()

  export default {
    components: {
      SingleGrammies
    },
    data: function() {
      return {
        genres: [],
        genre_id: '',
        artists: [],
        artist_songs: [],
        grammy_types: [{name: '最優秀レコード賞', value: 1}, {name: '最優秀楽曲賞', value: 2}],
        grammy_artist_id: '',
        grammy_song_id: '',
        grammy_type: '',
        grammy_year: '',
        grammy_years: this.generateYear(),
        dialog_title: '',
        dialog_message: '',
        grammy_dialog: false,
        grammyType: 'single'
      }
    },

    mounted () {
      genre.get().then(response => (this.genres = response.data)),
      artist.get().then(response => (this.artists = response.data))
    },

    methods: {
      fetchArtistSongs: function () {
      if (!this.grammy_artist_id) return;

        axios.get('/api/v1/songs/search', {params: { artist_id: this.grammy_artist_id }}).then((res) => {
          this.artist_songs = res.data
        }, (error) => {
          console.log(error);
        });
      },
      createGrammyOfSingleType: function () {
        if (!this.grammy_artist_id || !this.grammy_song_id || !this.grammy_type) return;

        axios.post('/api/v1/grammies', { artist_id: this.grammy_artist_id, song_id: this.grammy_song_id, grammy_type: this.grammy_type, genre_id: this.genre_id, year: this.grammy_year }).then((res) => {
          this.dialog_title = '登録成功'
          this.dialog_message = 'グラミー受賞作品に登録しました'
          this.grammy_dialog = true
        }, (error) => {
          this.dialog_title = '登録失敗'
          this.dialog_message = 'グラミー受賞作品に失敗しました'
          this.grammy_dialog = true
        });
      },

      generateYear: function (){
        const year = new Date().getFullYear()
        return Array.from({length: year - 1959}, (value, index) => 1959 + index)
      },

      buttonChange: function (type){
        this.grammyType = type
      }
    },
    watch: {
      grammy_artist_id: function() {
        this.fetchArtistSongs()
      }
    }
  }
</script>
