<template>
    <div id="room-info" class="ui card">
        <div class="content">
            <div class="header">
                {{name}}
            </div>
        </div>
        <div class="content">
            <div class="ui small feed">
                <user></user>
            </div>
        </div>
    </div>
</template>

<script>
    import User from "./user.vue";
    import Axios from "axios";

    export default {
        components: {User},
        data() {
            return {}
        },
        created() {
            this.name = "room name";
            this.users = [];
        }
    }
</script>
