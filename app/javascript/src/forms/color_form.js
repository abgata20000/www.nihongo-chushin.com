//
import {Vue} from "../libs/vue";

class ColorForm {
    static start() {
        const app = new Vue({
            el: "#color-form",
            data: {
                color: document.querySelector("[v-model='color']").value
            },
            methods: {
                changeColor: function(color) {
                    this.color = color;
                },
                isColorSelected: function (color) {
                    return this.color == color;
                }
            }
        });
        return app;
    }
}

export default ColorForm;

