<template>
    <div class="user-list-item">
        <img :class="userClass" :src="iconUrl" />
        <span class="username">
            {{user.nickname}}
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
            userClass() {
                return "user-icon color_" + this.user.color;
            },
            iconUrl() {
                return "/images/icon/" + this.user.icon + ".png";
            }
        }
    }
</script>
