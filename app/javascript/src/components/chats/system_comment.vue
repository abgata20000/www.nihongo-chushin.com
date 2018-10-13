<template>
    <div class="comment-wrap">
        <div class="system-comment">
            <span class="message">{{chat.comment}}</span>
            <span class="date">{{chat.created_at}}</span>
        </div>
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
