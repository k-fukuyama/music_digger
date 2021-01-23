<template>
  <v-app>
    <v-form @submit.prevent="createGrammyOfSingleType">
      <v-container>
        <v-row align="center">
          <v-col cols="12" sm="6">
          <v-autocomplete
            v-model="grammy_artist_id"
            :items="artists"
            item-text="name"
            item-value="id"
            label="アーティスト名"
            ></v-autocomplete>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
          <v-autocomplete
            v-model="grammy_song_id"
            :items="artist_songs"
            item-text="title"
            item-value="id"
            label="曲"
            ></v-autocomplete>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" md="6">
            <v-select
             v-model="grammy_type"
             item-text="name"
             item-value="value"
             :items="grammy_types"
              attach
              chips
              label="受賞部門"
            ></v-select>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" md="6">
            <v-select
             v-model="grammy_year"
             item-text="label"
             item-value="value"
             :items="grammy_years"
              attach
              chips
              label="受賞した年"
            ></v-select>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" md="6">
            <v-select
             v-model="genre_id"
             item-text="name"
             item-value="id"
             :items="genres"
              attach
              chips
              label="ジャンル"
            ></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-btn large color="primary" @click="createGrammyOfSingleType">グラミー受賞作品に登録</v-btn>
    </v-form>

    <v-row justify="center">
      <v-dialog v-model="grammy_dialog" persistent max-width="290">
        <v-card>
          <v-card-title class="headline">{{dialog_title}}</v-card-title>
          <v-card-text>{{dialog_message}}</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="grammy_dialog = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </v-app>
</template>

<script>
  import axios from 'axios';
  import Artist from '../../model/artist.js'
  import Genre from '../../model/genre.js'
  import Song from '../../model/song.js'
  import Discography from '../../model/discography.js'

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  const artist = new Artist()
  const genre = new Genre()

  export default {
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
        grammy_dialog: false
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
      }
    },
    watch: {
      grammy_artist_id: function() {
        this.fetchArtistSongs()
      }
    }
  }
</script>
