/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import '@mdi/font/css/materialdesignicons.css';
import Vue from 'vue';
import router from './routes.js';
import ArtisIndex from './components/artists/artists_index.vue'
import ArtistNew from './components/artists/artists_new.vue'
import GenresNew from './components/genres/genres_new.vue'
import DiscographiesNew from './components/discographies/discographies_new.vue'
import DiscographiesEdit from './components/discographies/discographies_edit.vue'
import GrammiesNew from './components/grammies/grammies_new.vue'

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const index = new Vue({
    el: '#index',
    router,
    vuetify: new Vuetify(),
    components: {
      'artist': ArtisIndex,
    }
  });

  new Vue({
    el: '#new',
    router,
    vuetify: new Vuetify(),
    components: {
      'new-form': ArtistNew
    }
  })

  new Vue({
    el: '#genres_new',
    router,
    vuetify: new Vuetify()
  })

  new Vue({
    el: '#discographies_new',
    router,
    vuetify: new Vuetify()
  })

  new Vue({
    el: '#discographies_edit',
    router,
    vuetify: new Vuetify()
  })

  new Vue({
    el: '#grammies_new',
    router,
    vuetify: new Vuetify()
  })

});


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
