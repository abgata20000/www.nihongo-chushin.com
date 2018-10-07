//
import {Vue} from "../common/vue";

class LoginForm {
    static start() {
        const app = new Vue({
            el: "#login-form",
            data: {
                icon: document.querySelector("[v-model='icon']").value,
                isShowSecret: false
            },
            methods: {
                changeIcon: function (icon) {
                    this.icon = icon;
                },
                isIconSelected: function (icon) {
                    return this.icon == icon;
                },
                toggleShowSecret: function () {
                    this.isShowSecret = !this.isShowSecret;
                }
            }
        });
        return app;
    }
}

export default LoginForm;

