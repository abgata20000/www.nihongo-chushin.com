<template>
    <div class="comment-wrap">
        <div class="right-content-wrap">
            <div class="right-content">
                <div class="desc medium" :class="chat.color_class" v-html="htmlComment"></div>
            </div>
        </div>
        <div class="left-content">
            <div class="user-info">
                <div class="avator medium" :class="chat.color_class">
                    <img :src="chat.icon_url" @click="addMention()" />
                    <div class="name">
                        {{chat.nickname}}
                    </div>
                </div>
            </div>
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
