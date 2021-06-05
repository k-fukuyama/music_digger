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
          <v-card-title class="headline">{{dialog_title}}</v-card-title>
          <v-card-text>{{dialog_text}}</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="dialog = false">閉じる</v-btn>
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
  import Genre from '../../model/genre.js'

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
        dialog_title: '',
        dialog_text: ''
      }
    },

    methods: {
      createGenre: function () {
        if (!this.genre.name) return;
        let self = this
        console.log(this.genre)
         new Genre().post(this.genre).then(response => {
           console.log(response) 
          this.dialog = true
          this.dialog_title = '登録成功'
          this.dialog_text = 'ジャンルを登録しました'
         })
         .catch(function (error) {
            console.log(error.response);
            self.dialog = true
            self.dialog_title = '登録失敗'
            self.dialog_text = 'ジャンルの登録に失敗しました'
          })
      }
    }
  }
</script>
