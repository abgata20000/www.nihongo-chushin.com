<template>
    <div class="comment-wrap">
        <div class="right-content-wrap">
            <div class="right-content">
                <div class="system">
                    <p class="message">{{chat.comment}}</p>
                    <p class="datetime">{{chat.created_at}}</p>
                </div>
            </div>
        </div>
        <div class="left-content"></div>
    </div>
</template>

<script>
    export default {
        props: ["chat"],
        data() {
            return {}
        }
    }
</script>
