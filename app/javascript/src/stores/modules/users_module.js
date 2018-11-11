const UsersModule = {
    namespaced: true,
    state: {users: []},
    getters: {
        users(state) {
            return state.users;
        }
    },
    mutations: {
        updateUsers(state, payload) {
            state.users = payload;
        }
    },
    actions: {
        updateUsers({commit}, payload) {
            commit("updateUsers", payload);
        }
    }
};
export default UsersModule;
