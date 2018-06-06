import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    storeData: {},
  },
  mutations: {
    newState(state, payload) {
      if(!state.storeData[payload.context]) state.storeData[payload.context] = payload.state

      for(const name of Object.keys(payload.state)) {
        state.storeData[payload.context][name] = payload.state[name]
      }
    }
  },
  getters: {
    getStoreData: (state) => state.storeData,
  },
  actions: {
    setState({commit}, payload) {
      commit('newState', payload)
    }
  }
})