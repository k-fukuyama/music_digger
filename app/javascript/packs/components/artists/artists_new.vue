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

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="生年月日"
              single-line
              @click.stop="dialog = true"
              v-model="artist.birth"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-btn large color="primary" @click="createArtist">登録</v-btn>
      </v-container>
    </v-form>

    <v-row justify="center">
        <v-dialog
          v-model="dialog"
          max-width="350"
        >
          <v-card>
            <v-card-title class="headline">生年月日を選択</v-card-title>

            <v-card-text>
              <v-date-picker v-model="picker"></v-date-picker>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                color="green darken-1"
                text
                v-on:click="birth_day_picker"
                @click="dialog = false"
              >
                登録
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-row>
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
        num: 100,

        picker: new Date().toISOString().substr(0, 10),
        dialog: false,
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

      },

      birth_day_picker: function () {
        this.artist.birth = this.picker
      }
    }
  }
</script>

<style scoped></style>
