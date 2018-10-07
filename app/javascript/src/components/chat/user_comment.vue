<template>
    <div class="comment-wrap">
        <div class="right-content-wrap">
            <div class="right-content">
                <div class="desc medium" :class="colorClass">
                    {{chat.comment}}
                </div>
            </div>
        </div>
        <div class="left-content">
            <div class="user-info">
                <div class="avator medium" :class="colorClass">
                    <img :src="iconUrl" />
                    <div class="name">
                        {{chat.nickname}}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ["chat"],
        data() {
            return {}
        },
        computed: {
            colorClass() {
                return "color_" + this.chat.color;
            },
            iconUrl() {
                return "/images/icon/" + this.chat.icon + ".png";
            }
        }
    }
</script>
