import router from './../libs/router'
import LoginForm from './../forms/login_form';

router('sessions', ['new', 'create'], () => {
    LoginForm.start();
});
