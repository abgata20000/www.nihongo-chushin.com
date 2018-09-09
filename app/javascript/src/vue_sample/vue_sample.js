//
import {Vue} from "../common/vue";
import App from '../components/app.vue'

class Vue_sample {
    run() {
        const el = document.body.appendChild(document.createElement('hello'));
        const app = new Vue({
            el,
            render: h => h(App)
        });
        return app;
    }
}

export default Vue_sample;

