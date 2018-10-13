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
            this.fetchUsers({}, true);
        },
        computed: {
            ...mapGetters("UsersModule", ["users"])
        },
        methods: {
            ...mapActions("UsersModule", ["updateUsers"]),
            fetchUsers(params = {},isInit = false) {
                this.$http.get(API_URL).then((res) => {
                    const myPage = res.data;
                    const users = res.data;
                    this.updateUsers(users);
                    if (isInit) {
                        this.$channel.setFetchUsersCallback(this.fetchUsers);
                    };
                });
            }
        }
    }
</script>
