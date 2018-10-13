import router from './../libs/router'
import ChatForm from './../forms/chat_form';

router('rooms', ['show'], () => {
    ChatForm.start();
});
