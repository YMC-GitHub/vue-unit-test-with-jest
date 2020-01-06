<!-- -----------src----------- -->
<!--
it is sfc file List
tasks:
use html tag ul li
use vue tpl txt,:key,v-for,props
list some items
-->
<!-- -----------src----------- -->

<template>
  <ul>
    <li :key="item" v-for="item in items">{{ item }}</li>
  </ul>
</template>

<script>
export default {
  name: "list",
  props: ["items"]
};
</script>
