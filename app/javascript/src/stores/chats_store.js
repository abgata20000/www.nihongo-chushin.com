import {Vuex} from "./../libs/vue";
import MyPageModule from "./modules/my_page_module";
import RoomModule from "./modules/room_module";
import ChatsModule from "./modules/chats_module";
import UsersModule from "./modules/users_module";
import CommentFormModule from "./modules/comment_form_module";
import {Vue} from "../libs/vue";
const vm = new Vue();
//
const ChatsStore = new Vuex.Store({
    modules: {
        MyPageModule,
        RoomModule,
        ChatsModule,
        UsersModule,
        CommentFormModule
    },
    state: {
        vm: vm
    },
    getters: {
        vm(state) {
            return state.vm;
        }
    },
});
export default ChatsStore;
