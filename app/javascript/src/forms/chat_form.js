//
import {Vue} from "../common/vue";
import Room from '../components/chat/room.vue'
import Chats from '../components/chat/chats.vue'

class ChatForm {
    static start(el = "#chat-form") {
        const app = new Vue({
            components: {
                Room,
                Chats
            }
        }).$mount(el);
        return app;
    }
}

export default ChatForm;

