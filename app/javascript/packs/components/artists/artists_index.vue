<template>
  <div id="app">
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <th>name</th>
          <th>department</th>
          <th>gender</th>
        </tr>
        <tr v-for="artist in artists" :key="artist.id">
          <td>{{ artist.id }}</td>
          <td>{{ artist.name }}</td>
          <td>{{ artist.department }}</td>
          <td>{{ artist.gender }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      artists: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/artists.json')
      .then(response => (this.artists = response.data))
  }
}
</script>
