import {Vuex} from "./../libs/vue";

const store = new Vuex.Store({
    state: {
        email: "",
        zip: "",
        address: ""
    },
    getters: {
        email(state) {
            return state.email;
        },
        zip(state) {
            return state.zip;
        },
        address(state) {
            return state.address;
        }
    },
    mutations: {
        updateEmail(state, payload) {
            state.email = payload;
        },

        updateZip(state, payload) {
            state.zip = payload;
        },
        updateAddress(state, payload) {
            state.address = payload;
        },
    },
    actions: {
        updateEmail({commit}, payload) {
            commit("updateEmail", payload);
        },

        updateZip({commit}, payload) {
            commit("updateZip", payload);
        },
        updateAddress({commit}, payload) {
            commit("updateAddress", payload);
        }
    }
});
export default store;
