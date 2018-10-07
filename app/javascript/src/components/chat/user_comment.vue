<template>
    <div class="comment-wrap">
        <div class="right-content-wrap">
            <div class="right-content">
                <div class="desc medium" :class="colorClass">
                    {{chat.comment}}
                </div>
            </div>
        </div>
        <div class="left-content">
            <div class="user-info">
                <div class="avator medium" :class="colorClass">
                    <img :src="iconUrl" @click="addMention()" />
                    <div class="name">
                        {{chat.nickname}}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import store from "../../stores/chat_store";
    import {mapGetters, mapActions} from "vuex";
    export default {
        props: ["chat"],
        store,
        data() {
            return {}
        },
        computed: {
            colorClass() {
                return "color_" + this.chat.color;
            },
            iconUrl() {
                return "/images/icon/" + this.chat.icon + ".png";
            },
            mention() {
                return "@" + this.chat.nickname;
            },
            ...mapGetters(["comment"])
        },
        methods: {
            ...mapActions(["updateComment"]),
            addMention() {
                let tmpComment = [this.mention, this.comment].join(" ");
                this.updateComment(tmpComment);
                // HACK: フォーカス当てるのが無理やりすぎるのでもっとスマートな方法で実装したい
                // vuexにメソッド登録できないものか…
                // もしくはpropsでメソッド渡してくるか(間に一つコンポーネント挟んでいるのでできれば別の方法がいい)
                this.$parent.$parent.setCommentFocus()
            }
        }
    }
</script>
