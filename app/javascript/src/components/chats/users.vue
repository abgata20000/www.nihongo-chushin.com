<template>
    <div id="users-info" class="content">
        <div class="ui small feed">
            <user v-for="user in users" :user="user"></user>
        </div>
    </div>
</template>

<script>
    import User from "./user.vue";
    import store from "../../stores/chats_store";
    import {mapGetters, mapActions} from "vuex";
    const API_URL = "/api/rooms/users";

    export default {
        components: {User},
        store,
        data() {
            return {}
        },
        mounted() {
            this.$channel.setFetchUsersCallback(this.fetchUsers);
            this.vm.$on("fetchUsers", this.fetchUsers);
        },
        computed: {
            ...mapGetters("UsersModule", ["users"]),
            ...mapGetters(["vm"])
        },
        methods: {
            ...mapActions("UsersModule", ["updateUsers"]),
            fetchUsers(params = {}) {
                this.$http.get(API_URL).then((res) => {
                    const users = res.data;
                    this.updateUsers(users);
                });
            }
        }
    }
</script>
