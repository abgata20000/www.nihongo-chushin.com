import {Vuex} from "./../libs/vue";
import MyPageModule from "./modules/my_page_module";
import RoomModule from "./modules/room_module";
import ChatsModule from "./modules/chats_module";
import UsersModule from "./modules/users_module";
import CommentFormModule from "./modules/comment_form_module";
//
const ChatsStore = new Vuex.Store({
    modules: {
        MyPageModule,
        RoomModule,
        ChatsModule,
        UsersModule,
        CommentFormModule
    }
});
export default ChatsStore;
