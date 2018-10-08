<template>
    <div id="room-info" class="ui card">
        <div class="content">
            <div class="header">
                {{room.room_name}}
            </div>
        </div>
        <users></users>
    </div>
</template>

<script>
    import Users from "./users.vue";
    import Axios from "axios";
    import store from "../../stores/chat_store";
    import {mapActions} from "vuex";

    const API_URL = "/api/room";
    export default {
        components: {Users},
        store,
        data() {
            return {
                room: {}
            }
        },
        created() {
            this.fetchRoom();
        },
        mounted() {
            this.$channel.setFetchRoomCallback(this.fetchRoom);
        },
        methods: {
            ...mapActions(["updateShowCommentCount", "updateCommentDisconnectedTime", "updateConnectionDisconnectedTime"]),
            fetchRoom() {
                Axios.get(API_URL)
                    .then((res) => {
                        this.room = res.data;
                        this.updateShowCommentCount(this.room.show_comment_count);
                        this.updateCommentDisconnectedTime(this.room.comment_disconnected_time);
                        this.updateConnectionDisconnectedTime(this.room.connection_disconnected_time);
                    });
            }
        }
    }
</script>
