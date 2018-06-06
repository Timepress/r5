export default {

  install(Vue, options) {
    Vue.prototype.$findComponents = function (name) {
      const names = Array.isArray(name) ? name : [name]
      function forEach(children) {
        const inputs = []

        for (const child of children) {
          if (names.includes(child.$options._componentTag)) {
            inputs.push(child)
          }

          if (child.$children && child.$children.length > 0) {
            inputs.push(...forEach(child.$children))
          }
        }
        return inputs;
      }
      return forEach(this.$children)
    }
  }
}