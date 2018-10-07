<template>
    <div id="comments-box">
        <div id="comment-form" class="field">
            <textarea id="comment-input"></textarea>
        </div>
        <ul id="comments">
            <chat v-for="chat in chats" :chat="chat"></chat>
        </ul>
    </div>
</template>

<script>
    import Chat from "./chat.vue";
    import Axios from "axios";

    const API_URL = "/api/chats";
    export default {
        components: {Chat},
        data() {
            return {
                chats: []
            }
        },
        created() {
            this.fetchChats();
        },
        methods: {
            fetchChats() {
                Axios.get(API_URL)
                    .then((res) => {
                        this.chats = res.data;
                    });
            }
        }
    }
</script>
