<template>
    <div class="user-list-item">
        <img class="user-icon" :class="user.color_class" :src="user.icon_url"/>
        <span class="username">
            {{showUserName}}
        </span>
    </div>
</template>

<script>
    export default {
        props: ["user"],
        data() {
            return {}
        },
        computed: {
            showUserName() {
                let tmpName = this.user.nickname;
                if (this.user.is_room_owner) {
                    tmpName = `${tmpName}(★)`;
                }
                return tmpName;
            }
        }
    }
</script>
