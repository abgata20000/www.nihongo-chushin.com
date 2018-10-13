const CommentFormModule = {
    namespaced: true,
    state: {
        comment: ""
    },
    getters: {
        comment(state) {
            return state.comment;
        }
    },
    mutations: {
        updateComment(state, payload) {
            state.comment = payload;
        }
    },
    actions: {
        updateComment({commit}, payload) {
            commit("updateComment", payload);
        }
    }
};
export default CommentFormModule;
