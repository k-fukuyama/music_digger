<template>
  <v-app>
    <v-form @submit.prevent="createDiscography">
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
                  <v-text-field
                    v-model="song.producer"
                    label="プロデューサー"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.composer"
                    label="作曲"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.lyricist"
                    label="作詞"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.vocalist"
                    label="ボーカル"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.bassist"
                    label="ベース"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.guitarist"
                    label="ギター"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.drummer"
                    label="ドラム"
                    outlined
                  ></v-text-field>
                </td>

                <td class="input-area-of-song">
                  <v-text-field
                    v-model="song.keyboardist"
                    label="キーボード"
                    outlined
                  ></v-text-field>
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

        <v-btn large color="primary" @click="createDiscography">登録</v-btn>

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
