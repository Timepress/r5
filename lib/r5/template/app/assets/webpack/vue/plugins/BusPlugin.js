export default {

  install(Vue, options) {

    this.vue = new Vue({data: {listeners: {}}})
    this.state = () => {return this.vue.$data}

    const that = this
    Vue.prototype.$busListen = function (name, callback) {
      if(!that.state().listeners[name]) that.state().listeners[name] = []
      that.state().listeners[name].push(callback)
    }

    Vue.prototype.$busEmit = function (name, value) {
      if(that.state().listeners[name])
        that.state().listeners[name].forEach(fn => {
          fn(value)
        })
    }
  }
}