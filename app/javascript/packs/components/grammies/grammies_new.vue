<template>
  <v-app>
    <v-card>
      <v-tabs
          background-color="deep-purple accent-4"
          center-active
          dark
      >
      <v-tab v-on:click="buttonChange('single')">Single</v-tab>
      <v-tab v-on:click="buttonChange('album')">Album</v-tab>
      </v-tabs>
    </v-card>
    <div v-show="grammyType=='single'">
      <SingleGrammies></SingleGrammies>
    </div>
    <div v-show="grammyType=='album'">
      <AlbumGrammies></AlbumGrammies>
    </div>
  </v-app>
</template>

<script>
  import SingleGrammies from './single_grammies.vue'
  import AlbumGrammies from './album_grammies.vue'

  export default {
    components: {
      SingleGrammies,
      AlbumGrammies
    },

    data: function() {
      return {
        grammyType: 'single'
      }
    },

    methods: {
      buttonChange: function (type){
        this.grammyType = type
      }
    }
  }
</script>
