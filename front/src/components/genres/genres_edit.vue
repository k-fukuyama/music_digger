<template>
  <v-app>
    <v-card-text>
      <v-container fluid>
        <v-layout wrap>
        <v-col cols="12">
          <v-form v-model="valid" @submit.prevent="updateGenre">
            <v-container>
              <v-row align="center">
                <v-col
                  cols="12"
                  md="4"
                >
                  <v-text-field
                    v-model="genre.name"
                    :rules="nameRules"
                    :counter="10"
                    label="ジャンル名"
                    required
                    outlined
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-btn large color="primary" @click="updateGenre(genre.id)">ジャンル更新</v-btn>
            </v-container>
          </v-form>
        </v-col>
        </v-layout>
      </v-container>
    </v-card-text>

    <v-row justify="center">
      <v-dialog v-model="genre_dialog" persistent max-width="290">
        <v-card>
          <v-card-title class="headline">{{dialog_title}}</v-card-title>
          <v-card-text>{{dialog_message}}</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="genre_dialog = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </v-app>
</template>

<v-textarea
          label="One row"
          auto-grow
          outlined
          rows="1"
          row-height="15"
        ></v-textarea>

<script>
  import axios from 'axios';

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  export default {
    data: function() {
      return {
        genre: {
          id: '',
          name: ''
        },

        valid: false,
        nameRules: [
          v => !!v || 'ジャンル名を入力してください'
        ],

        dialog: false,
        faildDialog: false,
        dialog_message: '',
        dialog_title: '',
        genre_dialog: ''
      }
    },

    mounted () {
      axios.get(`/api/v1/genres/${this.$route.params.id}/edit.json`).then(response => (this.genre = response.data))
    },

    methods: {
      updateGenre: function(id) {
        axios.patch(`/api/v1/genres/${id}`, { name: this.genre.name }).then((res) => {
          if (res.status == 200) {
            this.dialog_title = '更新成功'
            this.dialog_message = 'ジャンルを更新しました'
            this.genre_dialog = true
          }
        }, (error) => {
          this.dialog_title = '更新失敗'
          this.dialog_message = 'ジャンル更新に失敗しました'
          this.genre_dialog = true
        });
      }
    }
  }
</script>
