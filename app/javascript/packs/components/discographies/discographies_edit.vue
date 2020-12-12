<template>
  <v-app>
    <v-form @submit.prevent="updateDiscography">
      <v-container>
      <v-row align="center">
        <v-col cols="12" sm="6">
          <v-text-field
            label="アーティスト名"
            single-line
            v-model="discography.artist"
          ></v-text-field>
        </v-col>
      </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="タイトル"
              :rules="titleRules"
              single-line
              v-model="discography.title"
            ></v-text-field>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="レーベル"
              single-line
              v-model="discography.label"
            ></v-text-field>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="発売日"
              single-line
              @click.stop="dialog = true"
              v-model="discography.sales_start_at"
            ></v-text-field>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" sm="6">
            <v-text-field
              label="チャート最高順位"
              single-line
              v-model="discography.chart"
            ></v-text-field>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" md="6">
            <v-textarea
             outlined
             name="input-7-4"
             label="ディスコグラフィー説明"
             value=""
             v-model="discography.explanation"
            ></v-textarea>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-col cols="12" md="6">
            <v-select
             v-model="discography.discography_type"
             item-text="label"
             item-value="value"
             :items="discography_types"
              attach
              chips
              label="ディスコグラフィータイプ"
            ></v-select>
          </v-col>
        </v-row>

        <v-row align="center">
          <v-radio-group v-model="grammy_flg" row>
            <v-checkbox
              v-model="grammy_flg"
              label="グラミー受賞"
              class="mx-2"
            ></v-checkbox>
          </v-radio-group>
        </v-row>

        <v-row align="center">
          <v-radio-group v-model="selectedGenre" row>
            <v-checkbox
              v-for="genre in genres"
              v-model="selectedGenre"
              :key="genre.name"
              :label="genre.name"
              :value="genre.id"
              class="mx-2"
            ></v-checkbox>
          </v-radio-group>
        </v-row>

        <v-row align="center">
          <v-radio-group v-model="set_same_artist" row>
            <v-checkbox
              v-model="set_same_artist"
              label="1曲目のアーティスト構成を2曲目以降も維持する""
              class="mx-2"
            ></v-checkbox>
          </v-radio-group>
        </v-row>

        <v-simple-table>
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">No.</th>
                <th class="text-left">曲名</th>
                <th class="text-left">プロデューサー</th>
                <th class="text-left">作曲</th>
                <th class="text-left">作詞</th>
                <th class="text-left">ボーカル</th>
                <th class="text-left">ベース</th>
                <th class="text-left">ギター</th>
                <th class="text-left">ドラム</th>
                <th class="text-left">キーボード</th>
                <th class="text-left">再生時間</th>
              </tr>
            </thead>
            <tbody>
              <tr　v-for="(song, index) in songs" :key="song.id">
                <td class="indexdesuyo">
                  <p v-model="song.track_number">{{song.track_number = index + 1}}</p>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.title"
                    label="曲名"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.producer"
                    :items="artist_names"
                    label="プロデューサー"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.composer"
                    :items="artist_names"
                    label="作曲"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.lyricist"
                    :items="artist_names"
                    label="作詞"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.vocalist"
                    :items="artist_names"
                    label="ボーカル"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.bassist"
                    :items="artist_names"
                    label="ベース"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.guitarist"
                    :items="artist_names"
                    label="ギター"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.drummer"
                    :items="artist_names"
                    label="ドラム"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-autocomplete
                    v-model="song.keyboardist"
                    :items="artist_names"
                    label="キーボード"
                    outlined
                  ></v-autocomplete>
                </td>

                <td class="input-area-of-song">
                  <v-select
                    v-model="song.min"
                    :items="mins"
                    label="分"
                  ></v-select>
                </td>

                <td class="input-area-of-song">
                  <v-select
                    v-model="song.sec"
                    :items="secs"
                    label="秒"
                  ></v-select>
                </td>

                <td>
                  <v-btn
                    color="error"
                    v-on:click="deleteForm(index)"
                  >
                    削除
                  </v-btn>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>

        <v-btn large color="primary" @click="updateDiscography(discography.id)">登録</v-btn>

        <v-btn
          large
          color="green darken-1"
          v-on:click="addForm()"
        >
          追加
        </v-btn>
      </v-container>
    </v-form>

    <v-row justify="center">
      <v-dialog
        v-model="dialog"
        max-width="350"
      >
        <v-card>
          <v-card-title class="headline">発売日を選択</v-card-title>
            <v-card-text>
              <v-date-picker v-model="picker"></v-date-picker>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                color="green darken-1"
                text
                v-on:click="sales_start_at_picker"
                @click="dialog = false"
              >
                登録
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
    </v-row>

      <v-row justify="center">
        <v-dialog v-model="discography_dialog" persistent max-width="290">
          <v-card>
            <v-card-title class="headline">{{dialog_title}}</v-card-title>
            <v-card-text>{{dialog_message}}</v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="green darken-1" text @click="discography_dialog = false">閉じる</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-row>
  </v-app>
</template>

<script>
  import axios from 'axios';

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  const maxMin = 101
  const mins = [...Array(maxMin).keys()]
  const maxsecs = 60
  const secs = [...Array(maxsecs).keys()]

  export default {
    data: function() {
      return {
        discography: {
          id: '',
          artist: '',
          title: '',
          sales_start_at: '',
          label: '',
          chart: '',
          explanation: '',
          discography_type: 0
        },

        songs: [],

        edit_song_infos: [],

        picker: new Date().toISOString().substr(0, 10),
        dialog: false,

        genres: [],
        selectedGenre: [],
        grammy_flg: '',
        set_same_artist: '',
        mins: mins,
        secs: secs,
        discography_dialog: false,
        dialog_message: '',
        dialog_title: '',
        discography_types: [{label: 'シングル', value: 0}, {label: 'アルバム', value: 1}],

        titleRules: [
          v => !!v || 'タイトルを入力してください',
          v => v.length <= 20 || 'Name must be less than 10 characters',
        ]
      }
    },

    mounted () {
      axios
        .get('/api/v1/genres.json')
        .then(response => (this.genres = response.data)),

      axios
        .get(`/api/v1/discographies/${this.$route.params.id}/edit.json`)
        .then(response => (
                this.discography = response.data[0].discography,
                this.discography.artist = response.data[0].artist.name,
                this.setInfos(response.data[0].infos)
              )
         )
    },

    methods: {
      updateDiscography: function (id) {

        if (!this.discography.artist || !this.discography.title) {
          this.dialog_title = '更新失敗'
          this.dialog_message = 'アーティスト名、作品名の入力は必須です'
          this.discography_dialog = true
          return
        }

        for (var i = 0; i < this.songs.length; i++) {
          if (!this.songs[i].title) {
            this.dialog_title = '更新失敗'
            this.dialog_message = '曲名の入力は必須です'
            this.discography_dialog = true
            return
          }
        }

        axios.patch('/api/v1/discographies/${id}', { discography: this.discography, song_infos: this.songs, grammy_flg: this.grammy_flg, set_same_artist: this.set_same_artist }).then((res) => {
          this.dialog_title = '更新成功'
          this.dialog_message = 'ディスコグラフィーを更新しました'
          this.discography_dialog = true
        }, (error) => {
          this.dialog_title = '更新失敗'
          this.dialog_message = '更新に失敗しました'
          this.discography_dialog = true
        });
      },

      sales_start_at_picker: function () {
        this.discography.sales_start_at = this.picker
      },

      addForm() {
        this.songs.push(
          {
            track_number:"",
            title: "",
            producer: "",
            composer: "",
            lyricist: "",
            vocalist: "",
            bassist: "",
            guitarist: "",
            drummer: "",
            keyboardist: "",
            min: '',
            sec: ''
          }
        );
      },

      deleteForm(index) {
        console.log(index + 1)
        this.songs.splice(index, 1);
      },

      setInfos(songs) {
        for (var i = 0; i < songs.length; i++) {
        console.log(songs[i])
          this.songs.push(
            {
              id: songs[i]["id"],
              title: songs[i]["title"],
              producer: songs[i]["producer"],
              composer: songs[i]["composer"],
              lyricist: songs[i]["lyricist"],
              vocalist: songs[i]["vocalist"],
              guitarist: songs[i]["guitarist"],
              bassist:songs[i]["bassist"],
              drummer: songs[i]["drummer"],
              keyboardist: songs[i]["keyboardist"],
              min: songs[i]["min"],
              sec: songs[i]["sec"]
            }
          )
        }
      }
    }
  }
</script>

<style scoped>
  .input-area-of-song {
    min-width: 130px
  }
</style>
