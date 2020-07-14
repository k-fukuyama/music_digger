import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import Index from './components/app.vue';
import ArtistIndex from './components/artists/artists_index.vue';
import ArtistNew from './components/artists/artists_new.vue';



Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
    routes: [
    { path: '/', component: Index, name: 'root_path' },
    { path: '/artists/index', component: ArtistIndex, name: 'artists_index_path' },
    { path: '/artists/new',  component: ArtistNew }
  ]
});

export default router;
