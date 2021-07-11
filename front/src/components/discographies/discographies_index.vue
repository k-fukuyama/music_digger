<template>
  <v-app>
  <v-col cols="12">
    <v-form @submit.prevent="search">
      <v-text-field
        v-model="search_params"
        label="作品名で検索"
        outlined
        single-line
        append-icon="mdi-magnify"
        input="search"
      ></v-text-field>
     </v-form>
  </v-col>
    <v-simple-table>
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">作品名</th>
            <th class="text-left">アーティスト</th>
            <th class="text-left">レーベル</th>
            <th class="text-left">発売日</th>
          </tr>
        </thead>
          <tbody>
            <tr v-for="discography in discographies" :key="discography.id">
              <td>{{ discography.title }}</td>
              <td>{{ discography.artist_name }}</td>
              <td>{{ discography.label }}</td>
              <td>{{ discography.sales_start_at }}</td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
  </v-app>
</template>

<script>
  import Discography from '../../model/discography.js'
  const discography = new Discography()

  export default {
    data: function() {
      return {
        discography: discography.property(),
        discographies: '',
        search_params: ''
      }
    },

    created() {
      discography.getDiscography().then(response => (this.discographies = response.data))
    },

    methods: {
      search() {
       discography.getDiscography(this.search_params).then(response => (this.discographies = response.data))
      }
    }
  }
</script>

<style scoped>
  .input-area-of-song {
    min-width: 130px
  }
</style>
