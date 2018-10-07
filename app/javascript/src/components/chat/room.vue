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
    const API_URL = "/api/room";
    export default {
        components: {Users},
        data() {
            return {
                room: {}
            }
        },
        created() {
            this.fetchRoom();
        },
        methods: {
            fetchRoom(){
                Axios.get(API_URL)
                    .then((res) => {
                        this.room = res.data;
                    });
            }
        }
    }
</script>
