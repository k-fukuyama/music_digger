<template>
  <v-app>
    <v-card-text>
      <v-container fluid>
        <v-layout wrap>
        <v-col cols="12">
          <v-form v-model="valid" @submit.prevent="createGenre">
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
              <v-btn large color="primary" type="submit">登録</v-btn>
            </v-container>
          </v-form>
        </v-col>
        </v-layout>
      </v-container>
    </v-card-text>

    <v-row justify="center">
      <v-dialog v-model="dialog" persistent max-width="290">
        <v-card>
          <v-card-title class="headline">登録完了</v-card-title>
          <v-card-text>ジャンルを登録しました</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="dialog = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>

    <v-row justify="center">
      <v-dialog v-model="faildDialog" persistent max-width="290">
        <v-card>
          <v-card-title class="headline">登録失敗</v-card-title>
          <v-card-text>登録に失敗しました</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="faildDialog = false">閉じる</v-btn>
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
          name: ''
        },

        valid: false,
        genre_name: '',
        nameRules: [
          v => !!v || 'ジャンル名を入力してください'
        ],

        dialog: false,
        faildDialog: false
      }
    },

    methods: {
      createGenre: function () {
      if (!this.genre.name) return;

        axios.post('/api/v1/genres', { genre: this.genre }).then((res) => {
        console.log(res.status)
          if (res.status == 200) {
            this.dialog = true
          }
        }, (error) => {
          this.faildDialog = true
        });
      }
    }
  }
</script>
