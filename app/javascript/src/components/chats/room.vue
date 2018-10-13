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
        mounted() {
            this.fetchRoom({}, true);
        },
        computed: {
            ...mapGetters("RoomModule", ["room"])
        },
        methods: {
            ...mapActions("RoomModule", ["updateRoom"]),
            fetchRoom(params = {},isInit = false) {
                this.$http.get(API_URL).then((res) => {
                    const myPage = res.data;
                    this.updateRoom(myPage);
                    if (isInit) {
                        this.$channel.setFetchRoomCallback(this.fetchRoom);
                    };
                });
            }
        }
    }
</script>
