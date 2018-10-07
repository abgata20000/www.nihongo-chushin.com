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
    const API_URL = "/api/rooms/users";

    export default {
        components: {User},
        data() {
            return {
                users: []
            }
        },
        created() {
            this.fetchUsers();
        },
        mounted() {
            this.$channel.setFetchUsersCallback(this.fetchUsers);
        },
        methods: {
            fetchUsers() {
                Axios.get(API_URL)
                    .then((res) => {
                        this.users = res.data;
                    });
            }
        }
    }
</script>
