import {Vuex} from "./../common/vue";
const DEFAULT_SHOW_COMMENT_COUNT = 30;
const DEFAULT_COMMENT_DISCONNECTED_TIME = 900;
const DEFAULT_CONNECTION_DISCONNECTED_TIME = 60;

const store = new Vuex.Store({
    state: {
        comment: "",
        show_comment_count: DEFAULT_SHOW_COMMENT_COUNT,
        comment_disconnected_time: DEFAULT_COMMENT_DISCONNECTED_TIME,
        connection_disconnected_time: DEFAULT_CONNECTION_DISCONNECTED_TIME,
    },
    getters: {
        comment(state) {
            return state.comment;
        },
        show_comment_count(state) {
            return state.show_comment_count;
        },
        comment_disconnected_time(state) {
            return state.comment_disconnected_time;
        },
        connection_disconnected_time(state) {
            return state.connection_disconnected_time;
        }
    },
    mutations: {
        updateComment(state, payload) {
            state.comment = payload;
        },
        updateShowCommentCount(state, payload) {
            state.show_comment_count = payload;
        },
        updateCommentDisconnectedTime(state, payload) {
            state.comment_disconnected_time = payload;
        },
        updateConnectionDisconnectedTime(state, payload) {
            state.connection_disconnected_time = payload;
        }
    },
    actions: {
        updateComment({commit}, payload) {
            commit("updateComment", payload);
        },
        updateShowCommentCount({commit}, payload) {
            commit("updateShowCommentCount", payload);
        },
        updateCommentDisconnectedTime({commit}, payload) {
            commit("updateCommentDisconnectedTime", payload);
        },
        updateConnectionDisconnectedTime({commit}, payload) {
            commit("updateConnectionDisconnectedTime", payload);
        }
    }
});
export default store;
