<template>
    <ul class="comments-wrap">
        <comment v-for="chat in chats" :chat="chat"></comment>
    </ul>
</template>

<script>
    import Comment from "./comment.vue";
    import store from "../../stores/chats_store";
    import {mapGetters, mapActions} from "vuex";

    const API_URL = "/api/chats";
    export default {
        components: {Comment},
        store,
        data() {
            return {
                fetching: false,
                lastChatId: 0,
                nextFetch: false
            }
        },
        computed: {
            ...mapGetters("ChatsModule", ["chats"]),
            ...mapGetters("RoomModule",["showCommentCount"]),
            ...mapGetters(["vm"])
        },
        mounted() {
            this.$channel.setFetchCommentsCallback(this.fetchChats);
            this.vm.$on("fetchChats", this.fetchChats);
        },
        methods: {
            ...mapActions("ChatsModule", ["updateChats"]),
            fetchChats(params = {}) {
                if (this.fetching) {
                    this.nextFetch = true;
                    return;
                }
                this.fetching = true;
                this.nextFetch = false;
                let postParams = {last_chat_id: this.lastChatId};
                this.$http.get(API_URL, {params: postParams})
                    .then((res) => {
                        let chats = res.data;
                        this.addComments(chats);
                    })
                    .finally(() => {
                        this.fetching = false;
                        if (this.nextFetch) this.fetchChats();
                    });
            },
            addComments(chatsOrg) {
                const addedChats = chatsOrg.reverse();
                let tmpChats = this.chats;
                addedChats.forEach((chat) => {
                    tmpChats.unshift(chat);
                });
                let chats = this.decreaseComment(tmpChats);
                if(chats.length > 0) this.lastChatId = chats[0].id;
                this.updateChats(chats);
            },
            decreaseComment(chats) {
                let max = this.showCommentCount;
                let num = chats.length - max;
                if (num < 1) return chats;
                for (let i = 0; i < num; i++) {
                    chats.pop();
                }
                return chats;
            }
        }
    }
</script>

