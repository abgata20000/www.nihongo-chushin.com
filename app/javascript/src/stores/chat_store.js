import {Vuex} from "./../common/vue";
const DEFAULT_SHOW_COMMENT_COUNT = 30;

const store = new Vuex.Store({
    state: {
        comment: "",
        show_comment_count: DEFAULT_SHOW_COMMENT_COUNT
    },
    getters: {
        comment(state) {
            return state.comment;
        },
        show_comment_count(state) {
            return state.show_comment_count;
        }
    },
    mutations: {
        updateComment(state, payload) {
            state.comment = payload;
        },
        updateShowCommentCount(state, payload) {
            state.show_comment_count = payload;
        }
    },
    actions: {
        updateComment({commit}, payload) {
            commit("updateComment", payload);
        },

        updateShowCommentCount({commit}, payload) {
            commit("updateShowCommentCount", payload);
        }
    }
});
export default store;
