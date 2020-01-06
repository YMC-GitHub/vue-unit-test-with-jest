<!-- -----------src----------- -->
<!--
it is sfc file message
tasks:
use html tag h1
use vue tpl txt
show some messgae
-->
<!-- -----------src----------- -->

<template>
  <h1>{{ msg || 'default message' }}</h1>
</template>

<script>
export default {
  name: "message",
  props: ["msg"]
};
</script>
