<template>
<v-app>
  <v-form @submit.prevent="update()">
    <v-container>
      <v-row align="center">
        <v-col cols="12" sm="6">
          <v-text-field
          label="アーティスト名"
          :rules="nameRules"
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
          v-model="artist.birth_day"
          ></v-text-field>
        </v-col>
      </v-row>

      <v-row align="center">
        <v-col cols="12" sm="6">
          <v-select
          :items="genders"
          :rules="genderRules"
          label="性別"
          dense
          v-model="artist.gender"
          ></v-select>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
            label="国"
            single-line
            v-model="artist.country"
            ></v-text-field>
          </v-col>
        </v-row>

        <v-btn large color="primary" @click="update()">登録</v-btn>
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
  import Artist from '../../model/artist.js'

  const artist = new Artist()

  export default {
    data: function () {
      return {
        artist: '',
        picker: new Date().toISOString().substr(0, 10),
        dialog: false,
        genders: ["男性", "女性", "その他"],
        nameRules: [
          v => !!v || 'アーティスト名を入力してください',
          v => v.length <= 20 || 'Name must be less than 10 characters',
        ],
        genderRules: [
          v => !!v || '性別を選択してください'
        ]
      }
    },

    created () {
      artist
      .getById(this.$route.params.id)
      .then(response => (this.artist = response.data))
    },

    methods: {
       birth_day_picker: function () {
        this.artist.birth_day = this.picker
      },

      update() {
        if (!this.artist.name || !this.artist.gender) return;
        artist
        .update(this.artist)
        .then(response => (console.log(response.data)))
      }
    }
  }
</script>