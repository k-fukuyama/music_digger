<template>
  <v-app>
    <v-form v-model="valid" @submit.prevent="createArtist">
      <v-container>
        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="アーティスト名"
              single-line
              v-model="artist.name"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-btn large color="primary" @click="createArtist">登録</v-btn>
      </v-container>
    </v-form>
  </v-app>
</template>

<script>
  import axios from 'axios';
  import Datepicker from 'vuejs-datepicker';

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  export default {
    data: function() {
      return {
        artist: {
          name: '',
          gender: '',
          country: '',
          birth: ''
        },

        selected: null,
        list: [],
        num: 100
      }
    },

    components :{
      'vuejs-datepicker': Datepicker
    },

    created() {
      const year = new Date().getFullYear()

      for (let i = 0; i < this.num; i++) {
        this.list.unshift(year - i)
      }

      this.selected = this.list[this.list.length * 0.6]
    },

    methods: {
      createArtist: function () {
        if (!this.artist.name || !this.artist.gender) return;

        axios.post('/api/v1/artists', { artist: this.artist }).then((res) => {
          if (res.status == 200) {
            this.$router.push("/artists/index").catch(()=>{});
          }else{

          }
        }, (error) => {
          console.log(error);
        });
        this.$router.push("/artists/index")

      }
    }
  }
</script>

<style scoped></style>
