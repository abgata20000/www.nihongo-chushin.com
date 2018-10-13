<template>
    <div class="chat">
        <system-comment :chat="chat" v-if="chat.system_message"></system-comment>
        <user-comment :chat="chat" v-else></user-comment>
    </div>
</template>

<script>
    import SystemComment from "./system_comment";
    import UserComment from "./user_comment";
    export default {
        props: ["chat"],
        components: {
            "system-comment": SystemComment,
            "user-comment": UserComment,
        },
        data() {
            return {}
        }
    }
</script>

