//
import {Vue} from "../libs/vue";
import Chats from '../components/chats/chats.vue';
import ChatChannel from "../libs/chat_channel";
let chatChannel = new ChatChannel();
// refs: https://jp.vuejs.org/v2/cookbook/adding-instance-properties.html
Vue.prototype.$channel = chatChannel;
class ChatForm {
    static start(el = "#chat-form") {
        const app = new Vue({
            components: { Chats }
        }).$mount(el);
        return app;
    }
}

export default ChatForm;

