//----------src-----------
//it is a source file for js index
//----------src-----------
//tasks:
//use .vue index
//create vue instane 
//bind to html dom

//include some lib
import Vue from 'vue'
import App from './App.vue'

//create vue instane
new Vue({
  //bind to html dom with id "#app"
  el: '#app',
  render: h => h(App)
})
