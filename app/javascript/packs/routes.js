import Vue from 'vue';
import VueRouter from 'vue-router';
import Index from './components/app.vue';
import ArtistIndex from './components/artists/artists_index.vue';
import ArtistNew from './components/artists/artists_new.vue';
import GenresNew from './components/genres/genres_new.vue';
import DiscographiesNew from './components/discographies/discographies_new.vue';
import DiscographiesEdit from './components/discographies/discographies_edit.vue';
import GrammiesNew from './components/grammies/grammies_new.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
    routes: [
    { path: '/', component: Index, name: 'root_path' },
    { path: '/artists/index', component: ArtistIndex, name: 'artists_index_path' },
    { path: '/artists/new',  component: ArtistNew },
    { path: '/genres/new', component: GenresNew },
    { path: '/discographies/new', component: DiscographiesNew },
    { path: '/discographies/:id/edit', component: DiscographiesEdit },
    { path: '/grammies/new', component: GrammiesNew }
  ]
});

export default router;
