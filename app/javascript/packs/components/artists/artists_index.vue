<template>
  <v-app>
    <div>
      <v-container fluid>
        <v-layout wrap>
          <v-flex xs12 md12>
          <v-app-bar color="deep-purple accent-4" dark>
            <v-toolbar-title>Artists</v-toolbar-title>
          </v-app-bar>
          </v-flex>
        </v-layout>

        <v-col cols="12">
         <v-form @submit.prevent="submit" action="" method="get">
           <v-text-field
             v-model="search_params"
             label="Search Artist"
             outlined
             single-line
             append-icon="mdi-magnify"
             input="search"
             action='/api/v1/artists.json'
           ></v-text-field>
          </v-form>
        </v-col>

        <v-simple-table>
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">Name</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="artist in artists" :key="artist.name">
                <td>{{ artist.name }}</td>
                <td>{{ artist.gender }}</td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-container>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      artists: [],
      search_params: ""
    }
  },

  mounted () {
    axios
      .get('/api/v1/artists.json')
      .then(response => (this.artists = response.data))
  },

  methods: {
    submit() {
      axios
        .get('/api/v1/artists.json', {params:{ search_params: this.search_params}})
        .then(response => (this.artists = response.data))
    }
  }
}
</script>
