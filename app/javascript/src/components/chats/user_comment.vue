<template>
    <div class="comment">
        <figure :class="commentImageClass">
            <img :class="chat.color_class" :src="chat.icon_url" @click="addMention()" />
            <figcaption class="comment-img-description">
                {{chat.nickname}}
            </figcaption>
        </figure>
        <div :class="[chat.color_class, commentTextClass]">
            <p class="comment-text" :class="chat.color_class" v-html="htmlComment"></p>
        </div>
    </div>
</template>

<script>
    import autoLink from "autolink/src/index";
    import store from "../../stores/chats_store";
    import {mapGetters, mapActions} from "vuex";
    export default {
        props: ["chat"],
        store,
        data() {
            return {}
        },
        computed: {
            mention() {
                return `@${this.chat.nickname}`;
            },
            htmlComment() {
              return autoLink(this.chat.comment, {
                  email: true,
                  image: true,
                  br: true,
                  linkAttr: {target: '_blank'}
              });
            },
            userId() {
                return this.$store.getters["MyPageModule/myPage"].id;
            },
            isOwnComment() {
                return this.userId == this.chat.user_id;
            },
            commentTextClass() {
               return this.isOwnComment ? "comment-text-left" : "comment-text-right";
            },
            commentImageClass() {
                return this.isOwnComment ? "comment-img-right" : "comment-img-left";
            },
            ...mapGetters("CommentFormModule", ["comment"]),
            ...mapGetters(["vm"])
        },
        methods: {
            ...mapActions("CommentFormModule", ["updateComment"]),
            addMention() {
                let tmpComment = [this.mention, this.comment].join(" ");
                this.updateComment(tmpComment);
                // 無理矢理感漂うが他の方法が見つからない…
                this.vm.$emit("setCommentFocus");
            }
        }
    }
</script>
