<!-- -----------src----------- -->
<!--
it is a source file for .vue index
tasks:
use sfc MessageToggle 
use sfc List 

-->
<!-- -----------src----------- -->
<template>
  <div id="app">
    <message-toggle />
    <list :items="['list item 1', 'listen item 2']" />
  </div>
</template>

<script>
import MessageToggle from "@/components/MessageToggle.vue";
import List from "@/components/List.vue";

export default {
  components: {
    MessageToggle,
    List
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  color: #2c3e50;
}
</style>
