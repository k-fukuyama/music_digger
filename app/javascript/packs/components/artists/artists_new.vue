<template>
  <div class="container">
    <form class="col" @submit.prevent="createArtist">
      <div class="row">
        <div class="input-field">
          <input placeholder="アーティスト名" type="text" class="validate" v-model="artist.name" required="required"></br>
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <input placeholder="性別" type="text" class="validate" v-model="artist.gender" required="required">
        </div>
      </div>
      <div class="row">
        <div class="input-field">
          <input placeholder="国" type="text" class="validate" v-model="artist.country" required="required">
        </div>
      </div>
      <vuejs-datepicker v-model="artist.birth"></vuejs-datepicker>
      <input type="submit" value="アーティストを登録" class="btn btn-primary">
    </form>
  </div>
</template>

<script>
  import axios from 'axios';
  import Datepicker from 'vuejs-datepicker';

  const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
  axios.defaults.headers.common["X-CSRF-Token"] = token;

  export default {
    data: function() {
      return {
        artist: {
          name: '',
          gender: '',
          country: '',
          birth: ''
        },

        selected: null,
        list: [],
        num: 100
      }
    },

    components :{
      'vuejs-datepicker': Datepicker
    },

    created() {
      const year = new Date().getFullYear()

      for (let i = 0; i < this.num; i++) {
        this.list.unshift(year - i)
      }

      this.selected = this.list[this.list.length * 0.6]
    },

    methods: {
      createArtist: function () {
        if (!this.artist.name || !this.artist.gender) return;

        axios.post('/api/v1/artists', { artist: this.artist }).then((res) => {
          if (res.status == 200) {
            this.$router.push("/artists/index").catch(()=>{});
          }else{

          }
        }, (error) => {
          console.log(error);
        });
        this.$router.push("/artists/index")

      }
    }
  }
</script>

<style scoped></style>
