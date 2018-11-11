<template>
    <div id="comment-form" class="field">
            <textarea id="comment-input" ref="comment" v-model="comment"
                      @keypress.enter.prevent="postComment($event)"></textarea>
    </div>
</template>

<script>
    import store from "../../stores/chats_store";
    import {mapGetters, mapActions} from "vuex";
    const API_URL = "/api/chats";
    export default {
        store,
        data() {
            return {
                posting: false
            }
        },
        computed: {
            comment: {
                get() {
                    return this.$store.getters["CommentFormModule/comment"];
                },
                set(value) {
                    this.updateComment(value);
                }
            },
            ...mapGetters(["vm"])
        },
        mounted() {
            this.setCommentFocus();
            // 無理矢理感漂うが他の方法が見つからない…
            this.vm.$on("setCommentFocus", this.setCommentFocus);
        },
        methods: {
            ...mapActions("CommentFormModule", ["updateComment"]),
            setCommentFocus() {
                this.$refs.comment.focus();
            },
            postComment(event) {
                if (event.shiftKey) return this.addEnterToComment();
                if (this.comment.trim() === "") return this.resetComment();
                this.startPosting();
                let postParams = {comment: this.comment};
                this.resetComment();
                this.$http.post(API_URL, postParams)
                    .then((res) => {
                        // console.log(res.data);
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
            finishPosting() {
                this.posting = false;
                this.setCommentFocus();
            },
            startPosting() {
                this.posting = true;
            }
        }
    }
</script>
