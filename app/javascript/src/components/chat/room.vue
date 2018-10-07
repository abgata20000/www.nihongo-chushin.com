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
    export default {
        components: {Users},
        data() {
            return {
                room: {}
            }
        },
        created() {
            Axios.get("/api/room")
                .then((res) => {
                    this.room = res.data;
                });
        }
    }
</script>
