import Vue from 'vue/dist/vue.esm'
import BusPlugin from './vue/plugins/BusPlugin'
import HelperPlugin from './vue/plugins/HelperPlugin'
import Store from './store'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(HelperPlugin)
Vue.use(BusPlugin)
Vue.use(TurbolinksAdapter)

// #!if DEVELOPMENT

// This is there due plugin WebpackWatchFilesPlugin what call HotReload on '.rb', '.erb' (config) files
// but webpack ignore them because they're not javacripts and says nothing to reload.
// soo on invalid webpack reload action we refresh the page manually.

const SockJS = require('sockjs-client')
const url = require('url')

const connection = new SockJS(
  url.format({
    protocol: 'http',
    hostname: 'localhost',
    port: '9000',
    pathname: '/sockjs-node',
  })
)

connection.onmessage = function(e) {
  const message = JSON.parse(e.data)
  if(message.type === 'invalid') {
    Turbolinks.visit(window.location)
  }
}
// #!endif

const components = require.context('./vue/', true, /\.(vue)$/i)
function toObject(array) {
  const object = {}
  for(let i = 0; i < array.length; i++) {
    object[array[i].name] = array[i].component
  }
  return object;
}

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#vue-instance',
    store: Store,
    components: toObject(components.keys()
      .map(key => {
        const component = components(key)
        const name = component.default.name
        return {name: name, component: component.default}
      }))
  })
});