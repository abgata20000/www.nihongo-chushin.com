<template>
    <div id="chats-wrap">
        <div id="loading" v-show="loading">loading...</div>
        <div id="chats" v-show="!loading">
            <room></room>
            <comment-form></comment-form>
            <comments></comments>
        </div>
    </div>
</template>

<script>
    import {mapGetters, mapActions} from "vuex";
    import store from "../../stores/chats_store";
    import Room from "./room";
    import CommentForm from "./comment_form";
    import Comments from "./comments";
    const API_URL = "/api/my_page";
    export default {
        store,
        components: {
            Room,
            CommentForm,
            Comments
        },
        data() {
            return {
                loading: true
            }
        },
        mounted() {
            this.fetchMyPage();
        },
        computed: {
            ...mapGetters("MyPageModule",["myPage"]),
            ...mapGetters("RoomModule",["connectionDisconnectedTime"]),
            ...mapGetters(["vm"]),
            connectionWaitTime() {
                return this.connectionDisconnectedTime * 1000;
            }
        },
        methods: {
            ...mapActions("MyPageModule", ["updateMyPage"]),
            fetchMyPage() {
                this.$http.get(API_URL).then((res) => {
                    const myPage = res.data;
                    this.updateMyPage(myPage);
                    this.connect();
                });
            },
            connect() {
                // safariだと情報取得できなかったり、接続できなかったりするので少し時間をおく
                setTimeout(() => {
                    this.vm.$emit("fetchRoom");
                    this.vm.$emit("fetchUsers");
                    this.vm.$emit("fetchChats");
                    this.$channel.connected();
                    this.connectContinuation();
                    this.loaded();
                }, 500);
            },
            connectContinuation() {
                this.$channel.connect();
                setTimeout(() => {
                    this.connectContinuation();
                }, this.connectionWaitTime);
            },
            loaded(ts = 500) {
                setTimeout(() => {
                    this.loading = false;
                }, ts);
            }
        }
    }
</script>
<style scoped>

</style>
