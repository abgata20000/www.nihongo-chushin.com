<template>
    <div class="comment-wrap">
        <div class="right-content-wrap">
            <div class="right-content">
                <div class="system">
                    {{chat.comment}}
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
