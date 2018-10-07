<template>
    <div id="users-info" class="content">
        <div class="ui small feed">
            <user v-for="user in users" :user="user"></user>
        </div>
    </div>
</template>

<script>
    import User from "./user.vue";
    import Axios from "axios";
    export default {
        components: {User},
        data() {
            return {
                users: []
            }
        },
        created() {
            Axios.get("/api/rooms/users")
                .then((res) => {
                    console.log(res.data);
                    this.users = res.data;
                });
        }
    }
</script>
