//
import {Vue} from "../libs/vue";
import Room from '../components/chat/room.vue'
import Chats from '../components/chat/chats.vue'
import ChatChannel from "../libs/chat_channel";
let chatChannel = new ChatChannel();
// HACK: この方法でいいのかちょっと不安
Vue.prototype.$channel = chatChannel;
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

