<template>
    <div id="comments-box">
        <div id="comment-form" class="field">
            <textarea id="comment-input" ref="comment" v-model="comment"
                      @keypress.enter.prevent="postComment($event)"></textarea>
        </div>
        <ul id="comments">
            <chat v-for="chat in chats" :chat="chat"></chat>
        </ul>
    </div>
</template>

<script>
    import Chat from "./chat.vue";
    import Axios from "axios";
    import store from "../../stores/chat_store";
    import {mapGetters, mapActions} from "vuex";

    const API_URL = "/api/chats";
    export default {
        components: {Chat},
        store,
        data() {
            return {
                chats: [],
                posting: false,
                fetching: false,
                last_chat_id: 0,
                next_fetch: false
            }
        },
        computed: {
            comment: {
                get() {return this.$store.getters.comment},
                set(value) {this.updateComment(value)}
            },
            ...mapGetters(["show_comment_count"])
        },
        created() {
            this.fetchChats();
        },
        mounted() {
            this.setCommentFocus();
        },
        methods: {
            ...mapActions(["updateComment"]),
            fetchChats() {
                if (this.fetching) {
                    this.next_fetch = true;
                    return;
                }
                this.fetching = true;
                this.next_fetch = false;
                let params = {last_chat_id: this.last_chat_id};
                Axios.get(API_URL, params)
                    .then((res) => {
                        let chats = res.data.reverse();
                        chats.forEach((chat) => {
                            this.addComment(chat);
                        });
                    })
                    .finally(() => {
                        this.fetching = false;
                        if (this.next_fetch) this.fetchChats();
                    });
            },
            postComment(event) {
                if (event.shiftKey) return this.addEnterToComment();
                if (this.comment.trim() === "") return this.resetComment();
                this.startPosting();
                let postParams = {comment: this.comment};
                this.resetComment();
                Axios.post(API_URL, postParams)
                    .then((_res) => {
                        // let chat = res.data;
                        // this.addComment(chat);
                        this.fetchChats();
                    })
                    .finally(() => {
                        this.finishPosting();
                    });
            },
            resetComment() {
                this.comment = "";
            },
            addEnterToComment() {
                this.comment += "\n"
            },
            setCommentFocus() {
                this.$refs.comment.focus();
            },
            finishPosting() {
                this.posting = false;
                this.setCommentFocus();
            },
            startPosting() {
                this.posting = true;
            },
            addComment(chat) {
                this.last_chat_id = chat.id;
                this.chats.unshift(chat);
                this.decreaseComment();
            },
            decreaseComment() {
                let max = this.show_comment_count;
                let num = this.chats.length - max;
                if (num < 1) return;
                for (let i = 0; i < num; i++) {
                    this.chats.pop();
                }
            }
        }
    }
</script>
