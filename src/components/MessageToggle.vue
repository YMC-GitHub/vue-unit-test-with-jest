<!-- -----------src----------- -->
<!--
it is sfc file message-toggle
tasks:
include sfc message
use html tag button,div
use vue :msg,@click
toggle some messgae
-->
<!-- -----------src----------- -->

<template>
  <div>
    <message :msg="msg"></message>
    <button id="toggle-message" @click="toggleMessage">Change message</button>
  </div>
</template>

<script>
import Message from "@/components/Message.vue";

export default {
  name: "message-toggle",
  data: () => ({
    msg: null
  }),
  methods: {
    toggleMessage() {
      this.msg = this.msg === "message" ? "toggled message" : "message";
    }
  },
  components: {
    Message
  }
};
</script>
