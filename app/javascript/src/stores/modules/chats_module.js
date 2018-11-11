const ChatsModule = {
    namespaced: true,
    state: {
        chats: []
    },
    getters: {
        chats(state) {
            return state.chats;
        }
    },
    mutations: {
        updateChats(state, payload) {
            state.chats = payload;
        }
    },
    actions: {
        updateChats({commit}, payload) {
            commit("updateChats", payload);
        }
    }
};
export default ChatsModule;
