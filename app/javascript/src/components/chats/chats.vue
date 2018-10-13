<template>
    <div id="chats-wrap">
        <div id="chats">
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
            return {}
        },
        mounted() {
            this.fetchMyPage();
        },
        computed: {
            ...mapGetters("MyPageModule",["myPage"])
        },
        methods: {
            ...mapActions("MyPageModule", ["updateMyPage"]),
            fetchMyPage() {
                this.$http.get(API_URL).then((res) => {
                    const myPage = res.data;
                    this.updateMyPage(myPage);
                });
            }
        }
    }
</script>
<style scoped>

</style>
