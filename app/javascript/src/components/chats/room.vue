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
    import store from "../../stores/chats_store";
    import {mapGetters, mapActions} from "vuex";

    const API_URL = "/api/room";
    export default {
        components: {Users},
        store,
        data() {
            return {}
        },
        computed: {
            ...mapGetters("RoomModule", ["room"]),
            ...mapGetters(["vm"])
        },
        mounted() {
            this.$channel.setFetchRoomCallback(this.fetchRoom);
            this.vm.$on("fetchRoom", this.fetchRoom);
        },
        methods: {
            ...mapActions("RoomModule", ["updateRoom"]),
            fetchRoom(params = {}) {
                this.$http.get(API_URL).then((res) => {
                    const myPage = res.data;
                    this.updateRoom(myPage);
                });
            }
        }
    }
</script>
