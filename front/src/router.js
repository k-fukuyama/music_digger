import Vue from 'vue';
import VueRouter from 'vue-router';
import ArtistIndex from './components/artists/artists_index.vue';
import ArtistNew from './components/artists/artists_new.vue';
import ArtistEdit from './components/artists/artists_edit.vue';
import GenresNew from './components/genres/genres_new.vue';
// import GenresEdit from './components/genres/genres_edit.vue';
import DiscographiesNew from './components/discographies/discographies_new.vue';
import DiscographiesIndex from './components/discographies/discographies_index.vue';
// import DiscographiesEdit from './components/discographies/discographies_edit.vue';
// import GrammiesNew from './components/grammies/grammies_new.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
    routes: [
    { path: '/artists/index', component: ArtistIndex, name: 'artists_index_path' },
    { path: '/artists/new',  component: ArtistNew },
    { path: '/artists/edit/:id',  component: ArtistEdit, name: 'ArtistEdit'},
    { path: '/genres/new', component: GenresNew },
    { path: '/discographies/new', component: DiscographiesNew },
    { path: '/discographies/index', component: DiscographiesIndex },
    // { path: '/discographies/:id/edit', component: DiscographiesEdit },
    // { path: '/grammies/new', component: GrammiesNew },
    // { path: '/genres/:id/edit', component: GenresEdit }
  ]
});

export default router;
